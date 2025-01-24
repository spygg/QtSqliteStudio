/*
** Name:        codecext.c
** Purpose:     Implementation of SQLite codec API
** Author:      Ulrich Telle
** Created:     2006-12-06
** Copyright:   (c) 2006-2018 Ulrich Telle
** License:     LGPL-3.0+ WITH WxWindows-exception-3.1
*/

#ifndef SQLITE_OMIT_DISKIO
#ifdef SQLITE_HAS_CODEC

/*
** Include a "special" version of the VACUUM command
*/
#include "rekeyvacuum.c"

#include "codec.h"

void wx_sqlite3_activate_see(const char *info)
{
}

/*
// Free the encryption data structure associated with a pager instance.
// (called from the modified code in pager.c) 
*/
void wx_sqlite3CodecFree(void *pCodecArg)
{
  if (pCodecArg)
  {
    CodecTerm(pCodecArg);
    wx_sqlite3_free(pCodecArg);
    pCodecArg = NULL;
  }
}

void wx_sqlite3CodecSizeChange(void *pArg, int pageSize, int reservedSize)
{
  Codec* pCodec = (Codec*) pArg;
  pCodec->m_pageSize = pageSize;
  pCodec->m_reserved = reservedSize;
}

static void reportCodecError(Btree* pBt, int error)
{
  pBt->pBt->pPager->errCode = error;
  setGetterMethod(pBt->pBt->pPager);
  pBt->pBt->db->errCode = error;
}

/*
// Encrypt/Decrypt functionality, called by pager.c
*/
void* wx_sqlite3Codec(void* pCodecArg, void* data, Pgno nPageNum, int nMode)
{
  int rc = SQLITE_OK;
  Codec* codec = NULL;
  int pageSize;
  if (pCodecArg == NULL)
  {
    return data;
  }
  codec = (Codec*) pCodecArg;
  if (!CodecIsEncrypted(codec))
  {
    return data;
  }
  
  pageSize = wx_sqlite3BtreeGetPageSize(CodecGetBtree(codec));

  switch(nMode)
  {
    case 0: /* Undo a "case 7" journal file encryption */
    case 2: /* Reload a page */
    case 3: /* Load a page */
      if (CodecHasReadCipher(codec))
      {
        rc = CodecDecrypt(codec, nPageNum, (unsigned char*) data, pageSize);
        if (rc != SQLITE_OK) reportCodecError(CodecGetBtree(codec), rc);
      }
      break;

    case 6: /* Encrypt a page for the main database file */
      if (CodecHasWriteCipher(codec))
      {
        unsigned char* pageBuffer = CodecGetPageBuffer(codec);
        memcpy(pageBuffer, data, pageSize);
        data = pageBuffer;
        rc = CodecEncrypt(codec, nPageNum, (unsigned char*) data, pageSize, 1);
        if (rc != SQLITE_OK) reportCodecError(CodecGetBtree(codec), rc);
      }
      break;

    case 7: /* Encrypt a page for the journal file */
      /* Under normal circumstances, the readkey is the same as the writekey.  However,
         when the database is being rekeyed, the readkey is not the same as the writekey.
         The rollback journal must be written using the original key for the
         database file because it is, by nature, a rollback journal.
         Therefore, for case 7, when the rollback is being written, always encrypt using
         the database's readkey, which is guaranteed to be the same key that was used to
         read the original data.
      */
      if (CodecHasReadCipher(codec))
      {
        unsigned char* pageBuffer = CodecGetPageBuffer(codec);
        memcpy(pageBuffer, data, pageSize);
        data = pageBuffer;
        rc = CodecEncrypt(codec, nPageNum, (unsigned char*) data, pageSize, 0);
        if (rc != SQLITE_OK) reportCodecError(CodecGetBtree(codec), rc);
      }
      break;
  }
  return data;
}

void* mySqlite3PagerGetCodec(
  Pager *pPager
);

void mySqlite3PagerSetCodec(
  Pager *pPager,
  void *(*xCodec)(void*,void*,Pgno,int),
  void (*xCodecSizeChng)(void*,int,int),
  void (*xCodecFree)(void*),
  void *pCodec
);

static int mySqlite3AdjustBtree(Btree* pBt, int nPageSize, int nReserved, int isLegacy)
{
  int rc = SQLITE_OK;
  Pager* pager = wx_sqlite3BtreePager(pBt);
  int pagesize = wx_sqlite3BtreeGetPageSize(pBt);
  wx_sqlite3BtreeSecureDelete(pBt, 1);
  if (nPageSize > 0)
  {
    pagesize = nPageSize;
  }

  /* Adjust the page size and the reserved area */
  if (pager->nReserve != nReserved)
  {
    if (isLegacy != 0)
    {
      pBt->pBt->btsFlags &= ~BTS_PAGESIZE_FIXED;
    }
    rc = wx_sqlite3BtreeSetPageSize(pBt, pagesize, nReserved, 0);
  }
  return rc;
}

int wx_sqlite3CodecAttach(wx_sqlite3* db, int nDb, const void* zKey, int nKey)
{
  /* Attach a key to a database. */
  Codec* codec = (Codec*) wx_sqlite3_malloc(sizeof(Codec));
  int rc = (codec != NULL) ? CodecInit(codec) : SQLITE_NOMEM;
  if (rc != SQLITE_OK)
  {
    /* Unable to allocate memory for the codec base structure */
    return rc;
  }

  wx_sqlite3_mutex_enter(db->mutex);
  CodecSetDb(codec, db);

  /* No key specified, could mean either use the main db's encryption or no encryption */
  if (zKey == NULL || nKey <= 0)
  {
    /* No key specified */
    if (nDb != 0 && nKey > 0)
    {
      /* Main database possibly encrypted, no key explicitly given for attached database */
      Codec* mainCodec = (Codec*) mySqlite3PagerGetCodec(wx_sqlite3BtreePager(db->aDb[0].pBt));
      /* Attached database, therefore use the key of main database, if main database is encrypted */
      if (mainCodec != NULL && CodecIsEncrypted(mainCodec))
      {
        rc = CodecCopy(codec, mainCodec);
        if (rc == SQLITE_OK)
        {
          CodecSetBtree(codec, db->aDb[nDb].pBt);
          mySqlite3AdjustBtree(db->aDb[nDb].pBt, CodecGetPageSizeReadCipher(codec), CodecGetReservedReadCipher(codec), CodecGetLegacyReadCipher(codec));
#if (SQLITE_VERSION_NUMBER >= 3006016)
          mySqlite3PagerSetCodec(wx_sqlite3BtreePager(db->aDb[nDb].pBt), wx_sqlite3Codec, wx_sqlite3CodecSizeChange, wx_sqlite3CodecFree, codec);
#else
#if (SQLITE_VERSION_NUMBER >= 3003014)
          wx_sqlite3PagerSetCodec(wx_sqlite3BtreePager(db->aDb[nDb].pBt), wx_sqlite3Codec, codec);
#else
          wx_sqlite3pager_set_codec(wx_sqlite3BtreePager(db->aDb[nDb].pBt), wx_sqlite3Codec, codec);
#endif
          db->aDb[nDb].pAux = codec;
          db->aDb[nDb].xFreeAux = wx_sqlite3CodecFree;
#endif
        }
        else
        {
          /* Replicating main codec failed, do not attach incomplete codec */
          wx_sqlite3CodecFree(codec);
        }
      }
      else
      {
        /* Main database not encrypted */
        wx_sqlite3CodecFree(codec);
      }
    }
    else
    {
      /* Main database not encrypted, no key given for attached database */
      wx_sqlite3CodecFree(codec);
    }
  }
  else
  {
    /* Key specified, setup encryption key for database */
    CodecSetBtree(codec, db->aDb[nDb].pBt);
    rc = CodecSetup(codec, GetCipherType(db), (char*) zKey, nKey);
    if (rc == SQLITE_OK)
    {
      mySqlite3AdjustBtree(db->aDb[nDb].pBt, CodecGetPageSizeReadCipher(codec), CodecGetReservedReadCipher(codec), CodecGetLegacyReadCipher(codec));
#if (SQLITE_VERSION_NUMBER >= 3006016)
      mySqlite3PagerSetCodec(wx_sqlite3BtreePager(db->aDb[nDb].pBt), wx_sqlite3Codec, wx_sqlite3CodecSizeChange, wx_sqlite3CodecFree, codec);
#else
#if (SQLITE_VERSION_NUMBER >= 3003014)
      wx_sqlite3PagerSetCodec(wx_sqlite3BtreePager(db->aDb[nDb].pBt), wx_sqlite3Codec, codec);
#else
      wx_sqlite3pager_set_codec(wx_sqlite3BtreePager(db->aDb[nDb].pBt), wx_sqlite3Codec, codec);
#endif
      db->aDb[nDb].pAux = codec;
      db->aDb[nDb].xFreeAux = wx_sqlite3CodecFree;
#endif
    }
    else
    {
      /* Setting up codec failed, do not attach incomplete codec */
      wx_sqlite3CodecFree(codec);
    }
  }

  wx_sqlite3_mutex_leave(db->mutex);

  return rc;
}

void wx_sqlite3CodecGetKey(wx_sqlite3* db, int nDb, void** zKey, int* nKey)
{
  /*
  // The unencrypted password is not stored for security reasons
  // therefore always return NULL
  // If the main database is encrypted a key length of 1 is returned.
  // In that case an attached database will get the same encryption key
  // as the main database if no key was explicitly given for the attached database.
  */
  Codec* mainCodec = (Codec*) mySqlite3PagerGetCodec(wx_sqlite3BtreePager(db->aDb[0].pBt));
  int keylen = (mainCodec != NULL && CodecIsEncrypted(mainCodec)) ? 1 : 0;
  *zKey = NULL;
  *nKey = keylen;
}

static int dbFindIndex(wx_sqlite3* db, const char* zDb)
{
  int dbIndex = 0;
  if (zDb != NULL)
  {
    int found = 0;
    int index;
    for (index = 0; found == 0 && index < db->nDb; ++index)
    {
      struct Db* pDb = &db->aDb[index];
#if (SQLITE_VERSION_NUMBER >= 3015000)
      if (strcmp(pDb->zDbSName, zDb) == 0)
#else
      if (strcmp(pDb->zName, zDb) == 0)
#endif
      {
        found = 1;
        dbIndex = index;
      }
    }
    if (found == 0) dbIndex = 0;
  }
  return dbIndex;
}

int wx_sqlite3_key(wx_sqlite3 *db, const void *zKey, int nKey)
{
  /* The key is only set for the main database, not the temp database  */
  return wx_sqlite3_key_v2(db, "main", zKey, nKey);
}

int wx_sqlite3_key_v2(wx_sqlite3 *db, const char *zDbName, const void *zKey, int nKey)
{
  int rc = SQLITE_ERROR;
  if ((db != NULL) && (zKey != NULL) && (nKey > 0))
  {
    /* The key is only set for the main database, not the temp database  */
    int dbIndex = dbFindIndex(db, zDbName);
    rc = wx_sqlite3CodecAttach(db, dbIndex, zKey, nKey);
  }
  return rc;
}

int wx_sqlite3_rekey_v2(wx_sqlite3 *db, const char *zDbName, const void *zKey, int nKey)
{
  /* Changes the encryption key for an existing database. */
  int dbIndex = dbFindIndex(db, zDbName);
  int rc = SQLITE_ERROR;
  Btree* pBt = db->aDb[dbIndex].pBt;
  int nReserved;
  Pager* pPager;
  Codec* codec;

  wx_sqlite3BtreeEnter(pBt);
  nReserved = wx_sqlite3BtreeGetReserveNoMutex(pBt);
  wx_sqlite3BtreeLeave(pBt);

  pPager = wx_sqlite3BtreePager(pBt);
  codec = (Codec*) mySqlite3PagerGetCodec(pPager);

  if ((zKey == NULL || nKey == 0) && (codec == NULL || !CodecIsEncrypted(codec)))
  {
    /* Database not encrypted and key not specified, therefore do nothing	*/
    return SQLITE_OK;
  }

  wx_sqlite3_mutex_enter(db->mutex);

  if (codec == NULL || !CodecIsEncrypted(codec))
  {
    /* Database not encrypted, but key specified, therefore encrypt database	*/
    if (codec == NULL)
    {
      codec = (Codec*) wx_sqlite3_malloc(sizeof(Codec));
      rc = (codec != NULL) ? CodecInit(codec) : SQLITE_NOMEM;
    }
    if (rc == SQLITE_OK)
    {
      CodecSetDb(codec, db);
      CodecSetBtree(codec, pBt);
      rc = CodecSetupWriteCipher(codec, GetCipherType(db), (char*) zKey, nKey);
    }
    if (rc == SQLITE_OK)
    {
      int nReservedWriteCipher;

      CodecSetHasReadCipher(codec, 0); /* Original database is not encrypted */
      mySqlite3AdjustBtree(pBt, CodecGetPageSizeWriteCipher(codec), CodecGetReservedWriteCipher(codec), CodecGetLegacyWriteCipher(codec));
#if (SQLITE_VERSION_NUMBER >= 3006016)
      mySqlite3PagerSetCodec(pPager, wx_sqlite3Codec, wx_sqlite3CodecSizeChange, wx_sqlite3CodecFree, codec);
#else
#if (SQLITE_VERSION_NUMBER >= 3003014)
      wx_sqlite3PagerSetCodec(pPager, wx_sqlite3Codec, codec);
#else
      wx_sqlite3pager_set_codec(pPager, wx_sqlite3Codec, codec);
#endif
      db->aDb[dbIndex].pAux = codec;
      db->aDb[dbIndex].xFreeAux = wx_sqlite3CodecFree;
#endif
      nReservedWriteCipher = CodecGetReservedWriteCipher(codec);
      if (nReserved != nReservedWriteCipher)
      {
        /* Use VACUUM to change the number of reserved bytes */
        char* err;
        rc = wx_sqlite3RunVacuumForRekey(&err, db, dbIndex, nReservedWriteCipher);
        goto leave_rekey;
      }
    }
    else
    {
      return rc;
    }
  }
  else if (zKey == NULL || nKey == 0)
  {
    /* Database encrypted, but key not specified, therefore decrypt database */
    /* Keep read key, drop write key */
    CodecSetHasWriteCipher(codec, 0);
    if (nReserved > 0)
    {
      /* Use VACUUM to change the number of reserved bytes */
      char* err;
      rc = wx_sqlite3RunVacuumForRekey(&err, db, dbIndex, 0);
      goto leave_rekey;
    }
  }
  else
  {
    /* Database encrypted and key specified, therefore re-encrypt database with new key */
    /* Keep read key, change write key to new key */
    rc = CodecSetupWriteCipher(codec, GetCipherType(db), (char*) zKey, nKey);
    if (rc == SQLITE_OK)
    {
      int nReservedWriteCipher = CodecGetReservedWriteCipher(codec);
      if (nReserved != nReservedWriteCipher)
      {
        /* Use VACUUM to change the number of reserved bytes */
        char* err;
        rc = wx_sqlite3RunVacuumForRekey(&err, db, dbIndex, nReservedWriteCipher);
        goto leave_rekey;
      }
    }
    else
    {
      goto leave_rekey;
    }
  }

  /* Start transaction */
  rc = wx_sqlite3BtreeBeginTrans(pBt, 1);
  if (!rc)
  {
    int pageSize = wx_sqlite3BtreeGetPageSize(pBt);
    Pgno nSkip = WX_PAGER_MJ_PGNO(pageSize);
#if (SQLITE_VERSION_NUMBER >= 3003014)
    DbPage *pPage;
#else
    void *pPage;
#endif
    Pgno n;
    /* Rewrite all pages using the new encryption key (if specified) */
#if (SQLITE_VERSION_NUMBER >= 3007001)
    Pgno nPage;
    int nPageCount = -1;
    wx_sqlite3PagerPagecount(pPager, &nPageCount);
    nPage = nPageCount;
#elif (SQLITE_VERSION_NUMBER >= 3006000)
    int nPageCount = -1;
    int rc = wx_sqlite3PagerPagecount(pPager, &nPageCount);
    Pgno nPage = (Pgno) nPageCount;
#elif (SQLITE_VERSION_NUMBER >= 3003014)
    Pgno nPage = wx_sqlite3PagerPagecount(pPager);
#else
    Pgno nPage = wx_sqlite3pager_pagecount(pPager);
#endif

    for (n = 1; rc == SQLITE_OK && n <= nPage; n++)
    {
      if (n == nSkip) continue;
#if (SQLITE_VERSION_NUMBER >= 3010000)
      rc = wx_sqlite3PagerGet(pPager, n, &pPage, 0);
#elif (SQLITE_VERSION_NUMBER >= 3003014)
      rc = wx_sqlite3PagerGet(pPager, n, &pPage);
#else
      rc = wx_sqlite3pager_get(pPager, n, &pPage);
#endif
      if (!rc)
      {
#if (SQLITE_VERSION_NUMBER >= 3003014)
        rc = wx_sqlite3PagerWrite(pPage);
        wx_sqlite3PagerUnref(pPage);
#else
        rc = wx_sqlite3pager_write(pPage);
        wx_sqlite3pager_unref(pPage);
#endif
      }
    }
  }

  if (rc == SQLITE_OK)
  {
    /* Commit transaction if all pages could be rewritten */
    rc = wx_sqlite3BtreeCommit(pBt);
  }
  if (rc != SQLITE_OK)
  {
    /* Rollback in case of error */
#if (SQLITE_VERSION_NUMBER >= 3008007)
    /* Unfortunately this change was introduced in version 3.8.7.2 which cannot be detected using the SQLITE_VERSION_NUMBER */
    /* That is, compilation will fail for version 3.8.7 or 3.8.7.1  ==> Please change manually ... or upgrade to 3.8.7.2 or higher */
    wx_sqlite3BtreeRollback(pBt, SQLITE_OK, 0);
#elif (SQLITE_VERSION_NUMBER >= 3007011)
    wx_sqlite3BtreeRollback(pbt, SQLITE_OK);
#else
    wx_sqlite3BtreeRollback(pbt);
#endif
  }

leave_rekey:
  wx_sqlite3_mutex_leave(db->mutex);

/*leave_final:*/
  if (rc == SQLITE_OK)
  {
    /* Set read key equal to write key if necessary */
    if (CodecHasWriteCipher(codec))
    {
      CodecCopyCipher(codec, 0);
      CodecSetHasReadCipher(codec, 1);
    }
    else
    {
      CodecSetIsEncrypted(codec, 0);
    }
  }
  else
  {
    /* Restore write key if necessary */
    if (CodecHasReadCipher(codec))
    {
      CodecCopyCipher(codec, 1);
    }
    else
    {
      CodecSetIsEncrypted(codec, 0);
    }
  }

  if (!CodecIsEncrypted(codec))
  {
    /* Remove codec for unencrypted database */
#if (SQLITE_VERSION_NUMBER >= 3006016)
    mySqlite3PagerSetCodec(pPager, NULL, NULL, NULL, NULL);
#else
#if (SQLITE_VERSION_NUMBER >= 3003014)
    wx_sqlite3PagerSetCodec(pPager, NULL, NULL);
#else
    wx_sqlite3pager_set_codec(pPager, NULL, NULL);
#endif
    db->aDb[dbIndex].pAux = NULL;
    db->aDb[dbIndex].xFreeAux = NULL;
    wx_sqlite3CodecFree(codec);
#endif
  }
  return rc;
}

int wx_sqlite3_rekey(wx_sqlite3 *db, const void *zKey, int nKey)
{
  return wx_sqlite3_rekey_v2(db, "main", zKey, nKey);
}

#endif /* SQLITE_HAS_CODEC */

#endif /* SQLITE_OMIT_DISKIO */


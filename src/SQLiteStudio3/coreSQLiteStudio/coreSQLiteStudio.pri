#-------------------------------------------------
#
# Project created by QtCreator 2013-02-28T23:00:28
#
#-------------------------------------------------

# include($$PWD/../dirs.pri)
# include($$PWD/../utils.pri)



# QT       -= gui
QT       += script network




include($$PWD/sqlite3/sqlite3.pri)

win32 {
    LIBS += -lpsapi -limagehlp

    # THE_FILE = $$PWD/qt.conf
    # THE_DEST = $${DESTDIR}
    # THE_FILE ~= s,/,\\,g
    # THE_DEST ~= s,/,\\,g
    # QMAKE_POST_LINK += $$QMAKE_COPY $$THE_FILE $$THE_DEST $$escape_expand(\\n\\t)
}

linux: {
    DEFINES += SYS_PLUGINS_DIR=$$LIBDIR/sqlitestudio
    portable: {
        DESTDIR = $$DESTDIR/lib
    }
}

macx: {
    out_file = $$DESTDIR/lib $$TARGET .dylib
    QMAKE_POST_LINK += install_name_tool -change libsqlite3.dylib @loader_path/../Frameworks/libsqlite3.dylib $$join(out_file)
    QMAKE_POST_LINK += ; $$QMAKE_MKDIR $$DESTDIR/SQLiteStudio.app
    QMAKE_POST_LINK += ; $$QMAKE_MKDIR $$DESTDIR/SQLiteStudio.app/Contents
    QMAKE_POST_LINK += ; $$QMAKE_COPY $$PWD/Info.plist $$DESTDIR/SQLiteStudio.app/Contents
    LIBS += -L/usr/local/lib
}


DEFINES += CORESQLITESTUDIO_LIBRARY

portable {
    DEFINES += PORTABLE_CONFIG
}

CONFIG   += c++11
QMAKE_CXXFLAGS += -pedantic

SOURCES +=\
    $$PWD/sqlitestudio.cpp \
    $$PWD/returncode.cpp \
    $$PWD/services/config.cpp \
    $$PWD/common/nulldevice.cpp \
    $$PWD/parser/lexer_low_lev.cpp \
    $$PWD/common/utils.cpp \
    $$PWD/parser/keywords.cpp \
    $$PWD/common/utils_sql.cpp \
    $$PWD/parser/token.cpp \
    $$PWD/parser/lexer.cpp \
    $$PWD/parser/sqlite3_parse.cpp \
    $$PWD/parser/parsercontext.cpp \
    $$PWD/parser/parser.cpp \
    $$PWD/parser/sqlite2_parse.cpp \
    $$PWD/parser/ast/sqlitestatement.cpp \
    $$PWD/parser/ast/sqlitequery.cpp \
    $$PWD/parser/ast/sqlitealtertable.cpp \
    $$PWD/parser/ast/sqliteanalyze.cpp \
    $$PWD/parser/ast/sqlitebegintrans.cpp \
    $$PWD/parser/ast/sqlitecommittrans.cpp \
    $$PWD/parser/ast/sqlitecreateindex.cpp \
    $$PWD/parser/ast/sqlitecreatetable.cpp \
    $$PWD/parser/ast/sqlitecreatetrigger.cpp \
    $$PWD/parser/ast/sqlitecreateview.cpp \
    $$PWD/parser/ast/sqlitecreatevirtualtable.cpp \
    $$PWD/parser/ast/sqlitedelete.cpp \
    $$PWD/parser/ast/sqlitedetach.cpp \
    $$PWD/parser/ast/sqlitedroptable.cpp \
    $$PWD/parser/ast/sqlitedroptrigger.cpp \
    $$PWD/parser/ast/sqlitedropindex.cpp \
    $$PWD/parser/ast/sqlitedropview.cpp \
    $$PWD/parser/ast/sqliteinsert.cpp \
    $$PWD/parser/ast/sqlitepragma.cpp \
    $$PWD/parser/ast/sqlitereindex.cpp \
    $$PWD/parser/ast/sqlitesavepoint.cpp \
    $$PWD/parser/ast/sqliterelease.cpp \
    $$PWD/parser/ast/sqliterollback.cpp \
    $$PWD/parser/ast/sqliteselect.cpp \
    $$PWD/parser/ast/sqliteupdate.cpp \
    $$PWD/parser/ast/sqlitevacuum.cpp \
    $$PWD/parser/ast/sqlitecopy.cpp \
    $$PWD/parser/ast/sqliteemptyquery.cpp \
    $$PWD/parser/parser_helper_stubs.cpp \
    $$PWD/parser/ast/sqliteexpr.cpp \
    $$PWD/parser/ast/sqliteforeignkey.cpp \
    $$PWD/parser/ast/sqliteindexedcolumn.cpp \
    $$PWD/parser/ast/sqlitecolumntype.cpp \
    $$PWD/parser/ast/sqliteconflictalgo.cpp \
    $$PWD/parser/ast/sqlitesortorder.cpp \
    $$PWD/parser/ast/sqliteraise.cpp \
    $$PWD/parser/ast/sqliteorderby.cpp \
    $$PWD/parser/ast/sqlitelimit.cpp \
    $$PWD/parser/ast/sqliteattach.cpp \
    $$PWD/parser/parsererror.cpp \
    $$PWD/selectresolver.cpp \
    $$PWD/schemaresolver.cpp \
    $$PWD/parser/ast/sqlitequerytype.cpp \
    $$PWD/db/db.cpp \
    $$PWD/services/dbmanager.cpp \
    $$PWD/db/sqlresultsrow.cpp \
    $$PWD/db/asyncqueryrunner.cpp \
    $$PWD/completionhelper.cpp \
    $$PWD/completioncomparer.cpp \
    $$PWD/db/queryexecutor.cpp \
    $$PWD/qio.cpp \
    $$PWD/plugins/pluginsymbolresolver.cpp \
    $$PWD/db/sqlerrorresults.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorstep.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorcountresults.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorparsequery.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorexecute.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorattaches.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutoraddrowids.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorlimit.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorcolumns.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorcellsize.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutororder.cpp \
    $$PWD/db/sqlerrorcodes.cpp \
    $$PWD/common/readwritelocker.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorwrapdistinctresults.cpp \
    $$PWD/csvformat.cpp \
    $$PWD/csvserializer.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutordatasources.cpp \
    $$PWD/expectedtoken.cpp \
    $$PWD/sqlhistorymodel.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorexplainmode.cpp \
    $$PWD/services/notifymanager.cpp \
    $$PWD/parser/statementtokenbuilder.cpp \
    $$PWD/parser/ast/sqlitedeferrable.cpp \
    $$PWD/tablemodifier.cpp \
    $$PWD/db/chainexecutor.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorreplaceviews.cpp \
    $$PWD/services/codeformatter.cpp \
    $$PWD/viewmodifier.cpp \
    $$PWD/log.cpp \
    $$PWD/plugins/plugintype.cpp \
    $$PWD/plugins/genericplugin.cpp \
    $$PWD/common/memoryusage.cpp \
    $$PWD/ddlhistorymodel.cpp \
    $$PWD/datatype.cpp \
    $$PWD/common/table.cpp \
    $$PWD/common/column.cpp \
    $$PWD/dbattacher.cpp \
    $$PWD/services/functionmanager.cpp \
    $$PWD/plugins/scriptingqt.cpp \
    $$PWD/services/impl/configimpl.cpp \
    $$PWD/services/impl/dbmanagerimpl.cpp \
    $$PWD/db/abstractdb.cpp \
    $$PWD/services/impl/functionmanagerimpl.cpp \
    $$PWD/services/impl/pluginmanagerimpl.cpp \
    $$PWD/impl/dbattacherimpl.cpp \
    $$PWD/db/dbsqlite3.cpp \
    $$PWD/plugins/dbpluginsqlite3.cpp \
    $$PWD/parser/ast/sqlitewith.cpp \
    $$PWD/services/impl/collationmanagerimpl.cpp \
    $$PWD/services/exportmanager.cpp \
    $$PWD/exportworker.cpp \
    $$PWD/plugins/scriptingsql.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutordetectschemaalter.cpp \
    $$PWD/querymodel.cpp \
    $$PWD/plugins/genericexportplugin.cpp \
    $$PWD/dbobjectorganizer.cpp \
    $$PWD/db/attachguard.cpp \
    $$PWD/db/invaliddb.cpp \
    $$PWD/dbversionconverter.cpp \
    $$PWD/diff/diff_match_patch.cpp \
    $$PWD/db/sqlquery.cpp \
    $$PWD/db/queryexecutorsteps/queryexecutorvaluesmode.cpp \
    $$PWD/services/importmanager.cpp \
    $$PWD/importworker.cpp \
    $$PWD/services/populatemanager.cpp \
    $$PWD/pluginservicebase.cpp \
    $$PWD/populateworker.cpp \
    $$PWD/plugins/populatesequence.cpp \
    $$PWD/plugins/populaterandom.cpp \
    $$PWD/plugins/populaterandomtext.cpp \
    $$PWD/plugins/populateconstant.cpp \
    $$PWD/plugins/populatedictionary.cpp \
    $$PWD/plugins/populatescript.cpp \
    $$PWD/plugins/builtinplugin.cpp \
    $$PWD/plugins/scriptingqtdbproxy.cpp \
    $$PWD/plugins/sqlformatterplugin.cpp \
    $$PWD/services/updatemanager.cpp \
    $$PWD/config_builder/cfgmain.cpp \
    $$PWD/config_builder/cfgcategory.cpp \
    $$PWD/config_builder/cfgentry.cpp \
    $$PWD/config_builder/cfglazyinitializer.cpp \
    $$PWD/committable.cpp \
    $$PWD/services/extralicensemanager.cpp \
    $$PWD/tsvserializer.cpp \
    $$PWD/rsa/BigInt.cpp \
    $$PWD/rsa/Key.cpp \
    $$PWD/rsa/KeyPair.cpp \
    $$PWD/rsa/PrimeGenerator.cpp \
    $$PWD/rsa/RSA.cpp \
    $$PWD/translations.cpp \
    $$PWD/common/signalwait.cpp \
    $$PWD/common/blockingsocket.cpp \
    $$PWD/common/threadwitheventloop.cpp \
    $$PWD/common/private/blockingsocketprivate.cpp \
    $$PWD/querygenerator.cpp \
    $$PWD/common/bistrhash.cpp \
    $$PWD/plugins/dbpluginstdfilebase.cpp \
    $$PWD/common/xmldeserializer.cpp \
    $$PWD/services/impl/sqliteextensionmanagerimpl.cpp \
    $$PWD/common/lazytrigger.cpp \
    $$PWD/parser/ast/sqliteupsert.cpp

HEADERS +=\
    $$PWD/sqlitestudio.h\
    $$PWD/coreSQLiteStudio_global.h \
    $$PWD/returncode.h \
    $$PWD/services/config.h \
    $$PWD/common/nulldevice.h \
    $$PWD/parser/lexer_low_lev.h \
    $$PWD/common/utils.h \
    $$PWD/parser/keywords.h \
    $$PWD/parser/token.h \
    $$PWD/common/utils_sql.h \
    $$PWD/parser/lexer.h \
    $$PWD/parser/sqlite3_parse.h \
    $$PWD/parser/parsercontext.h \
    $$PWD/parser/parser.h \
    $$PWD/parser/sqlite2_parse.h \
    $$PWD/parser/ast/sqlitestatement.h \
    $$PWD/parser/ast/sqlitequery.h \
    $$PWD/parser/ast/sqlitealtertable.h \
    $$PWD/parser/ast/sqliteanalyze.h \
    $$PWD/parser/ast/sqlitebegintrans.h \
    $$PWD/parser/ast/sqlitecommittrans.h \
    $$PWD/parser/ast/sqlitecreateindex.h \
    $$PWD/parser/ast/sqlitecreatetable.h \
    $$PWD/parser/ast/sqlitecreatetrigger.h \
    $$PWD/parser/ast/sqlitecreateview.h \
    $$PWD/parser/ast/sqlitecreatevirtualtable.h \
    $$PWD/parser/ast/sqlitedelete.h \
    $$PWD/parser/ast/sqlitedetach.h \
    $$PWD/parser/ast/sqlitedroptable.h \
    $$PWD/parser/ast/sqlitedroptrigger.h \
    $$PWD/parser/ast/sqlitedropindex.h \
    $$PWD/parser/ast/sqlitedropview.h \
    $$PWD/parser/ast/sqliteinsert.h \
    $$PWD/parser/ast/sqlitepragma.h \
    $$PWD/parser/ast/sqlitereindex.h \
    $$PWD/parser/ast/sqlitesavepoint.h \
    $$PWD/parser/ast/sqliterelease.h \
    $$PWD/parser/ast/sqliterollback.h \
    $$PWD/parser/ast/sqliteselect.h \
    $$PWD/parser/ast/sqliteupdate.h \
    $$PWD/parser/ast/sqlitevacuum.h \
    $$PWD/parser/ast/sqlitecopy.h \
    $$PWD/parser/ast/sqlitequerytype.h \
    $$PWD/parser/ast/sqliteemptyquery.h \
    $$PWD/parser/parser_helper_stubs.h \
    $$PWD/parser/ast/sqliteconflictalgo.h \
    $$PWD/parser/ast/sqliteexpr.h \
    $$PWD/parser/ast/sqliteforeignkey.h \
    $$PWD/parser/ast/sqliteindexedcolumn.h \
    $$PWD/parser/ast/sqlitecolumntype.h \
    $$PWD/parser/ast/sqlitesortorder.h \
    $$PWD/parser/ast/sqlitedeferrable.h \
    $$PWD/parser/ast/sqliteraise.h \
    $$PWD/parser/ast/sqliteorderby.h \
    $$PWD/parser/ast/sqlitelimit.h \
    $$PWD/parser/ast/sqliteattach.h \
    $$PWD/parser/parsererror.h \
    $$PWD/common/objectpool.h \
    $$PWD/selectresolver.h \
    $$PWD/schemaresolver.h \
    $$PWD/dialect.h \
    $$PWD/db/db.h \
    $$PWD/services/dbmanager.h \
    $$PWD/db/sqlresultsrow.h \
    $$PWD/db/asyncqueryrunner.h \
    $$PWD/completionhelper.h \
    $$PWD/expectedtoken.h \
    $$PWD/completioncomparer.h \
    $$PWD/plugins/dbplugin.h \
    $$PWD/services/pluginmanager.h \
    $$PWD/db/queryexecutor.h \
    $$PWD/qio.h \
    $$PWD/db/dbpluginoption.h \
    $$PWD/common/global.h \
    $$PWD/parser/ast/sqlitetablerelatedddl.h \
    $$PWD/plugins/pluginsymbolresolver.h \
    $$PWD/db/sqlerrorresults.h \
    $$PWD/db/sqlerrorcodes.h \
    $$PWD/db/queryexecutorsteps/queryexecutorstep.h \
    $$PWD/db/queryexecutorsteps/queryexecutorcountresults.h \
    $$PWD/db/queryexecutorsteps/queryexecutorparsequery.h \
    $$PWD/db/queryexecutorsteps/queryexecutorexecute.h \
    $$PWD/db/queryexecutorsteps/queryexecutorattaches.h \
    $$PWD/db/queryexecutorsteps/queryexecutoraddrowids.h \
    $$PWD/db/queryexecutorsteps/queryexecutorlimit.h \
    $$PWD/db/queryexecutorsteps/queryexecutorcolumns.h \
    $$PWD/db/queryexecutorsteps/queryexecutorcellsize.h \
    $$PWD/common/unused.h \
    $$PWD/db/queryexecutorsteps/queryexecutororder.h \
    $$PWD/common/readwritelocker.h \
    $$PWD/db/queryexecutorsteps/queryexecutorwrapdistinctresults.h \
    $$PWD/csvformat.h \
    $$PWD/csvserializer.h \
    $$PWD/db/queryexecutorsteps/queryexecutordatasources.h \
    $$PWD/sqlhistorymodel.h \
    $$PWD/db/queryexecutorsteps/queryexecutorexplainmode.h \
    $$PWD/services/notifymanager.h \
    $$PWD/parser/statementtokenbuilder.h \
    $$PWD/tablemodifier.h \
    $$PWD/db/chainexecutor.h \
    $$PWD/db/queryexecutorsteps/queryexecutorreplaceviews.h \
    $$PWD/plugins/sqlformatterplugin.h \
    $$PWD/services/codeformatter.h \
    $$PWD/viewmodifier.h \
    $$PWD/log.h \
    $$PWD/plugins/plugintype.h \
    $$PWD/plugins/plugin.h \
    $$PWD/plugins/genericplugin.h \
    $$PWD/common/memoryusage.h \
    $$PWD/ddlhistorymodel.h \
    $$PWD/datatype.h \
    $$PWD/plugins/generalpurposeplugin.h \
    $$PWD/common/table.h \
    $$PWD/common/column.h \
    $$PWD/common/bihash.h \
    $$PWD/common/strhash.h \
    $$PWD/dbattacher.h \
    $$PWD/common/bistrhash.h \
    $$PWD/services/functionmanager.h \
    $$PWD/common/sortedhash.h \
    $$PWD/plugins/scriptingplugin.h \
    $$PWD/plugins/scriptingqt.h \
    $$PWD/services/impl/configimpl.h \
    $$PWD/services/impl/dbmanagerimpl.h \
    $$PWD/db/abstractdb.h \
    $$PWD/services/impl/functionmanagerimpl.h \
    $$PWD/services/impl/pluginmanagerimpl.h \
    $$PWD/impl/dbattacherimpl.h \
    $$PWD/db/abstractdb3.h \
    $$PWD/db/dbsqlite3.h \
    $$PWD/plugins/dbpluginsqlite3.h \
    $$PWD/db/abstractdb2.h \
    $$PWD/parser/ast/sqlitewith.h \
    $$PWD/services/collationmanager.h \
    $$PWD/services/impl/collationmanagerimpl.h \
    $$PWD/plugins/exportplugin.h \
    $$PWD/config_builder.h \
    $$PWD/services/exportmanager.h \
    $$PWD/exportworker.h \
    $$PWD/plugins/scriptingsql.h \
    $$PWD/db/queryexecutorsteps/queryexecutordetectschemaalter.h \
    $$PWD/querymodel.h \
    $$PWD/plugins/genericexportplugin.h \
    $$PWD/dbobjectorganizer.h \
    $$PWD/db/attachguard.h \
    $$PWD/interruptable.h \
    $$PWD/db/invaliddb.h \
    $$PWD/dbversionconverter.h \
    $$PWD/diff/diff_match_patch.h \
    $$PWD/db/sqlquery.h \
    $$PWD/dbobjecttype.h \
    $$PWD/db/queryexecutorsteps/queryexecutorvaluesmode.h \
    $$PWD/plugins/importplugin.h \
    $$PWD/services/importmanager.h \
    $$PWD/importworker.h \
    $$PWD/plugins/populateplugin.h \
    $$PWD/services/populatemanager.h \
    $$PWD/pluginservicebase.h \
    $$PWD/populateworker.h \
    $$PWD/plugins/populatesequence.h \
    $$PWD/plugins/populaterandom.h \
    $$PWD/plugins/populaterandomtext.h \
    $$PWD/plugins/populateconstant.h \
    $$PWD/plugins/populatedictionary.h \
    $$PWD/plugins/populatescript.h \
    $$PWD/plugins/builtinplugin.h \
    $$PWD/plugins/scriptingqtdbproxy.h \
    $$PWD/plugins/codeformatterplugin.h \
    $$PWD/services/updatemanager.h \
    $$PWD/config_builder/cfgmain.h \
    $$PWD/config_builder/cfgcategory.h \
    $$PWD/config_builder/cfgentry.h \
    $$PWD/config_builder/cfglazyinitializer.h \
    $$PWD/plugins/confignotifiableplugin.h \
    $$PWD/committable.h \
    $$PWD/plugins/uiconfiguredplugin.h \
    $$PWD/services/extralicensemanager.h \
    $$PWD/db/stdsqlite3driver.h \
    $$PWD/tsvserializer.h \
    $$PWD/rsa/BigInt.h \
    $$PWD/rsa/Key.h \
    $$PWD/rsa/KeyPair.h \
    $$PWD/rsa/PrimeGenerator.h \
    $$PWD/rsa/RSA.h \
    $$PWD/translations.h \
    $$PWD/common/signalwait.h \
    $$PWD/common/blockingsocket.h \
    $$PWD/common/threadwitheventloop.h \
    $$PWD/common/private/blockingsocketprivate.h \
    $$PWD/common/expiringcache.h \
    $$PWD/parser/ast/sqliteddlwithdbcontext.h \
    $$PWD/parser/ast/sqliteextendedindexedcolumn.h \
    $$PWD/querygenerator.h \
    $$PWD/common/sortedset.h \
    $$PWD/plugins/dbpluginstdfilebase.h \
    $$PWD/common/xmldeserializer.h \
    $$PWD/common/valuelocker.h \
    $$PWD/services/sqliteextensionmanager.h \
    $$PWD/services/impl/sqliteextensionmanagerimpl.h \
    $$PWD/common/lazytrigger.h \
    $$PWD/parser/ast/sqliteupsert.h

unix: {
    target.path = $$LIBDIR
    INSTALLS += target
}

OTHER_FILES += \
    $$PWD/parser/lempar.c \
    $$PWD/parser/lemon.c \
    $$PWD/parser/sqlite3_parse.y \
    $$PWD/parser/sqlite2_parse.y \
    $$PWD/parser/run_lemon.sh \
    $$PWD/TODO.txt \
    $$PWD/licenses/fugue_icons.txt \
    $$PWD/licenses/qhexedit.txt \
    $$PWD/licenses/sqlitestudio_license.txt \
    $$PWD/licenses/lgpl.txt \
    $$PWD/licenses/diff_match.txt \
    $$PWD/licenses/gpl.txt \
    $$PWD/ChangeLog.txt \
    $$PWD/qt.conf\
    $$PWD/Info.plist

FORMS += \
    $$PWD/plugins/populatesequence.ui \
    $$PWD/plugins/populaterandom.ui \
    $$PWD/plugins/populaterandomtext.ui \
    $$PWD/plugins/populateconstant.ui \
    $$PWD/plugins/populatedictionary.ui \
    $$PWD/plugins/populatescript.ui

RESOURCES += \
    $$PWD/coreSQLiteStudio.qrc

DISTFILES += \
    $$PWD/licenses/mit.txt
















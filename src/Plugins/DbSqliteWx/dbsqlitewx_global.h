#ifndef DBSQLITEWX_GLOBAL_H
#define DBSQLITEWX_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(DBSQLITEWX_LIBRARY)
#  define DBSQLITEWXSHARED_EXPORT Q_DECL_EXPORT
#else
#  define DBSQLITEWXSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // DBSQLITEWX_GLOBAL_H

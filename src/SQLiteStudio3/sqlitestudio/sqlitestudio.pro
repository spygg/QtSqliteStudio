#-------------------------------------------------
#
# Project created by QtCreator 2014-09-06T00:39:26
#
#-------------------------------------------------

QT       += core gui widgets network

include($$PWD/../dirs.pri)
include($$PWD/../utils.pri)
include($$PWD/../complietype/complietype.pri)



contains(DEFINES, NO_USEDLLS){
    include($$PWD/../coreSQLiteStudio/coreSQLiteStudio.pri)
    include($$PWD/../guiSQLiteStudio/guiSQLiteStudio.pri)
}else{
    OBJECTS_DIR = $$OBJECTS_DIR/sqlitestudio
    MOC_DIR = $$MOC_DIR/sqlitestudio
    UI_DIR = $$UI_DIR/sqlitestudio
    LIBS += -lcoreSQLiteStudio -lguiSQLiteStudio
}

linux {
    TARGET = sqlitestudio
} else {
    TARGET = SQLiteStudio
}
TEMPLATE = app

CONFIG   += c++11
QMAKE_CXXFLAGS += -pedantic

DEFINES += QAPPLICATION_CLASS=QApplication

win32 {
    msvc:LIBS += Advapi32.lib
    gcc:LIBS += -lAdvapi32
}

portable {
    DEFINES += PORTABLE_CONFIG
    linux {
        QMAKE_LFLAGS += -Wl,-rpath,./lib
    }
}


SOURCES +=\
    $$PWD/main.cpp \
    $$PWD/singleapplication/singleapplication.cpp

TRANSLATIONS +=\
    $$PWD/translations/sqlitestudio_ro_RO.ts \
    $$PWD/translations/sqlitestudio_de.ts \
    $$PWD/translations/sqlitestudio_it.ts \
    $$PWD/translations/sqlitestudio_zh_CN.ts \
    $$PWD/translations/sqlitestudio_sk.ts \
    $$PWD/translations/sqlitestudio_ru.ts \
    $$PWD/translations/sqlitestudio_pt_BR.ts \
    $$PWD/translations/sqlitestudio_fr.ts \
    $$PWD/translations/sqlitestudio_es.ts \
    $$PWD/translations/sqlitestudio_pl.ts

win32 {
    RC_FILE = windows.rc
    msvc:LIBS += User32.lib
    gcc:LIBS += -lUser32
}

macx {
    ICON = ../guiSQLiteStudio/img/sqlitestudio.icns
}

OTHER_FILES += \
    windows.rc \
    SQLiteStudio.exe.manifest

unix {
    target.path = $$BINDIR
    INSTALLS += target
}

RESOURCES += \
    $$PWD/sqlitestudio.qrc

HEADERS += \
    $$PWD/singleapplication/singleapplication.h \
    $$PWD/singleapplication/singleapplication_p.h
















#include <QApplication>
#include <QCommandLineOption>
#include <QCommandLineParser>
#include <QDebug>
#include <QDir>
#include <QMessageBox>
#include <QPluginLoader>
#include <QProcess>
#include <QSplashScreen>
#include <QThread>
#include "completionhelper.h"
#include "coreSQLiteStudio_global.h"
#include "datagrid/sqlquerymodel.h"
#include "datagrid/sqlquerymodelcolumn.h"
#include "dataview.h"
#include "dbtree/dbtree.h"
#include "dbtree/dbtreeitem.h"
#include "dialogs/languagedialog.h"
#include "dialogs/triggerdialog.h"
#include "guiSQLiteStudio_global.h"
#include "iconmanager.h"
#include "log.h"
#include "mainwindow.h"
#include "multieditor/multieditorbool.h"
#include "multieditor/multieditordate.h"
#include "multieditor/multieditordatetime.h"
#include "multieditor/multieditortime.h"
#include "qio.h"
#include "services/pluginmanager.h"
#include "services/updatemanager.h"
#include "singleapplication/singleapplication.h"
#include "sqleditor.h"
#include "sqlitestudio.h"
#include "translations.h"
#include "uiconfig.h"
#include "uidebug.h"
#include "windows/editorwindow.h"
#include "windows/tablewindow.h"
#include "windows/viewwindow.h"

#include "services/dbmanager.h"

#ifdef Q_OS_WIN
#   include <windef.h>
#   include <windows.h>
#endif

static bool listPlugins = false;

QString uiHandleCmdLineArgs(bool applyOptions = true)
{
    QCommandLineParser parser;
    parser.setApplicationDescription(QObject::tr("GUI interface to SQLiteStudio, a SQLite manager."));
    parser.addHelpOption();
    parser.addVersionOption();

    QCommandLineOption debugOption({"d", "debug"}, QObject::tr("Enables debug messages in console (accessible with F12)."));
    QCommandLineOption debugStdOutOption("debug-stdout", QObject::tr("Redirects debug messages into standard output (forces debug mode)."));
    QCommandLineOption debugFileOption("debug-file", QObject::tr("Redirects debug messages into given file (forces debug mode)."), QObject::tr("log file"));
    QCommandLineOption lemonDebugOption("debug-lemon", QObject::tr("Enables Lemon parser debug messages for SQL code assistant."));
    QCommandLineOption sqlDebugOption("debug-sql", QObject::tr("Enables debugging of every single SQL query being sent to any database."));
    QCommandLineOption sqlDebugDbNameOption("debug-sql-db", QObject::tr("Limits SQL query messages to only the given <database>."), QObject::tr("database"));
    QCommandLineOption executorDebugOption("debug-query-executor", QObject::tr("Enables debugging of SQLiteStudio's query executor."));
    QCommandLineOption listPluginsOption("list-plugins", QObject::tr("Lists plugins installed in the SQLiteStudio and quits."));
    QCommandLineOption masterConfigOption("master-config", QObject::tr("Points to the master configuration file. Read manual at wiki page for more details."), QObject::tr("SQLiteStudio settings file"));
    parser.addOption(debugOption);
    parser.addOption(debugStdOutOption);
    parser.addOption(debugFileOption);
    parser.addOption(lemonDebugOption);
    parser.addOption(sqlDebugOption);
    parser.addOption(sqlDebugDbNameOption);
    parser.addOption(executorDebugOption);
    parser.addOption(masterConfigOption);
    parser.addOption(listPluginsOption);

    parser.addPositionalArgument(QObject::tr("file"), QObject::tr("Database file to open"));

    parser.process(qApp->arguments());

    if (applyOptions)
    {
        bool enableDebug = parser.isSet(debugOption) || parser.isSet(debugStdOutOption) || parser.isSet(sqlDebugOption) || parser.isSet(debugFileOption);
        setUiDebug(enableDebug, !parser.isSet(debugStdOutOption), parser.value(debugFileOption));
        CompletionHelper::enableLemonDebug = parser.isSet(lemonDebugOption);
        setSqlLoggingEnabled(parser.isSet(sqlDebugOption));
        setExecutorLoggingEnabled(parser.isSet(executorDebugOption));
        if (parser.isSet(sqlDebugDbNameOption))
            setSqlLoggingFilter(parser.value(sqlDebugDbNameOption));

        if (parser.isSet(listPluginsOption))
            listPlugins = true;

        if (parser.isSet(masterConfigOption))
            Config::setMasterConfigFile(parser.value(masterConfigOption));
    }

    QStringList args = parser.positionalArguments();
    if (args.size() > 0)
        return args[0];

    return QString::null;
}

int main(int argc, char *argv[])
{
    SingleApplication a(argc, argv, true, SingleApplication::ExcludeAppPath|SingleApplication::ExcludeAppVersion);

    if (a.isSecondary()) {
#ifdef Q_OS_WIN
        AllowSetForegroundWindow(DWORD( a.primaryPid()));
#endif
        QString dbToOpen = uiHandleCmdLineArgs();
        a.sendMessage(serializeToBytes(dbToOpen));
        return 0;
    }

    qInstallMessageHandler(uiMessageHandler);

    QString dbToOpen = uiHandleCmdLineArgs();

    DbTreeItem::initMeta();
    SqlQueryModelColumn::initMeta();
    SqlQueryModel::staticInit();

    SQLITESTUDIO->setInitialTranslationFiles({"coreSQLiteStudio", "guiSQLiteStudio", "sqlitestudio"});
    SQLITESTUDIO->init(a.arguments(), true);
    IconManager::getInstance()->init();
    DbTree::staticInit();
    DataView::staticInit();
    EditorWindow::staticInit();
    TableWindow::staticInit();
    ViewWindow::staticInit();
    MultiEditorDateTime::staticInit();
    MultiEditorTime::staticInit();
    MultiEditorDate::staticInit();
    MultiEditorBool::staticInit();
    TriggerDialog::staticInit();

    MainWindow* mainWin = MAINWINDOW;

    QObject::connect(&a, &SingleApplication::receivedMessage, mainWin, &MainWindow::messageFromSecondaryInstance);

    SQLITESTUDIO->initPlugins();

    if (listPlugins)
    {
        for (const PluginManager::PluginDetails& details : PLUGINS->getAllPluginDetails())
            qOut << details.name << " " << details.versionString << "\n";

        return 0;
    }

    IconManager::getInstance()->rescanResources();

    // if (!LanguageDialog::didAskForDefaultLanguage())
    // {
    //     LanguageDialog::askedForDefaultLanguage();
    //     QMap<QString, QString> langs = getAvailableLanguages();

    //     LanguageDialog dialog;
    //     dialog.setLanguages(langs);
    //     dialog.setSelectedLang(getConfigLanguageDefault());
    //     if (dialog.exec() == QDialog::Accepted)
    //         setDefaultLanguage(dialog.getSelectedLang());

    //     QProcess::startDetached(a.applicationFilePath(), QStringList());
    //     return 0;
    // }

    // Shortcuts titles needs to be retranslated, because their titles were set initially in global scope,
    // while translation files were not loaded yet. Now they are.
    ExtActionContainer::refreshShortcutTranslations();

    MainWindow::getInstance()->restoreSession();
    MainWindow::getInstance()->show();

    if (!dbToOpen.isNull())
        MainWindow::getInstance()->openDb(dbToOpen);

    //说明过去没有历史
    if (DBLIST->getDbList().size() <= 0) {
        QDir dir = QDir(a.applicationDirPath());

        QStringList filters;
        filters << "*.db";

        // 获取当前路径下所有符合过滤器的文件信息列表
        QFileInfoList list = dir.entryInfoList(filters, QDir::Files);

        // 遍历文件信息列表并输出文件名
        foreach (QFileInfo fileInfo, list) {
            MainWindow::getInstance()->openDb(fileInfo.fileName());
        }
    }

#ifdef PORTABLE_CONFIG
        //UPDATES->checkForUpdates();
#endif

    return a.exec();
}

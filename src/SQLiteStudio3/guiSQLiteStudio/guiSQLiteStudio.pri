#-------------------------------------------------
#
# Project created by QtCreator 2013-02-28T23:22:10
#
#-------------------------------------------------

QT       += core gui uitools widgets xml svg

# include($$PWD/../dirs.pri)
# include($$PWD/../utils.pri)



linux: {
    portable: {
        DESTDIR = $$DESTDIR/lib
    }
}

portable: {
    DEFINES += PORTABLE_CONFIG
}


CONFIG += c++11
QMAKE_CXXFLAGS += -pedantic

DEFINES += GUISQLITESTUDIO_LIBRARY


SOURCES +=\
    $$PWD/mainwindow.cpp\
    $$PWD/iconmanager.cpp\
    $$PWD/dbtree/dbtreemodel.cpp\
    $$PWD/dbtree/dbtreeitem.cpp\
    $$PWD/dbtree/dbtree.cpp\
    $$PWD/dbtree/dbtreeview.cpp\
    $$PWD/actionentry.cpp\
    $$PWD/uiutils.cpp\
    $$PWD/dbtree/dbtreeitemdelegate.cpp\
    $$PWD/dbtree/dbtreeitemfactory.cpp\
    $$PWD/sqleditor.cpp\
    $$PWD/datagrid/sqlquerymodel.cpp\
    $$PWD/dblistmodel.cpp\
    $$PWD/mdiarea.cpp\
    $$PWD/statusfield.cpp\
    $$PWD/common/tablewidget.cpp\
    $$PWD/datagrid/sqlqueryitem.cpp\
    $$PWD/datagrid/sqlqueryview.cpp\
    $$PWD/datagrid/sqlquerymodelcolumn.cpp\
    $$PWD/datagrid/sqlqueryitemdelegate.cpp\
    $$PWD/common/extlineedit.cpp\
    $$PWD/common/intvalidator.cpp\
    $$PWD/common/widgetcover.cpp\
    $$PWD/mdiwindow.cpp\
    $$PWD/mdichild.cpp\
    $$PWD/taskbar.cpp\
    $$PWD/multieditor/multieditor.cpp\
    $$PWD/multieditor/multieditorwidget.cpp\
    $$PWD/widgetresizer.cpp\
    $$PWD/multieditor/multieditortext.cpp\
    $$PWD/multieditor/multieditornumeric.cpp\
    $$PWD/common/numericspinbox.cpp\
    $$PWD/multieditor/multieditordatetime.cpp\
    $$PWD/multieditor/multieditordate.cpp\
    $$PWD/multieditor/multieditortime.cpp\
    $$PWD/formview.cpp\
    $$PWD/multieditor/multieditorbool.cpp\
    $$PWD/multieditor/multieditorhex.cpp\
    $$PWD/qhexedit2/xbytearray.cpp\
    $$PWD/qhexedit2/qhexedit_p.cpp\
    $$PWD/qhexedit2/qhexedit.cpp\
    $$PWD/qhexedit2/commands.cpp\
    $$PWD/multieditor/multieditordialog.cpp\
    $$PWD/completer/completerwindow.cpp\
    $$PWD/completer/completermodel.cpp\
    $$PWD/completer/completeritemdelegate.cpp\
    $$PWD/completer/completerview.cpp\
    $$PWD/dialogs/searchtextdialog.cpp\
    $$PWD/searchtextlocator.cpp\
    $$PWD/windows/tablewindow.cpp\
    $$PWD/windows/editorwindow.cpp\
    $$PWD/datagrid/sqltablemodel.cpp\
    $$PWD/dataview.cpp\
    $$PWD/windows/tablestructuremodel.cpp\
    $$PWD/windows/tableconstraintsmodel.cpp\
    $$PWD/dialogs/columndialog.cpp\
    $$PWD/dialogs/columndialogconstraintsmodel.cpp\
    $$PWD/common/extactioncontainer.cpp\
    $$PWD/common/extaction.cpp\
    $$PWD/constraints/tableprimarykeypanel.cpp\
    $$PWD/constraints/constraintpanel.cpp\
    $$PWD/constraints/tableforeignkeypanel.cpp\
    $$PWD/constraints/tableuniquepanel.cpp\
    $$PWD/constraints/tablepkanduniquepanel.cpp\
    $$PWD/constraints/tablecheckpanel.cpp\
    $$PWD/constraints/columncheckpanel.cpp\
    $$PWD/constraints/constraintcheckpanel.cpp\
    $$PWD/constraints/columnforeignkeypanel.cpp\
    $$PWD/constraints/columnprimarykeypanel.cpp\
    $$PWD/constraints/columnuniquepanel.cpp\
    $$PWD/constraints/columnuniqueandnotnullpanel.cpp\
    $$PWD/constraints/columnnotnullpanel.cpp\
    $$PWD/constraints/columncollatepanel.cpp\
    $$PWD/constraints/columndefaultpanel.cpp\
    $$PWD/dialogs/constraintdialog.cpp\
    $$PWD/dialogs/newconstraintdialog.cpp\
    $$PWD/windows/constrainttabmodel.cpp\
    $$PWD/dialogs/messagelistdialog.cpp\
    $$PWD/windows/viewwindow.cpp\
    $$PWD/dialogs/configdialog.cpp\
    $$PWD/uiconfig.cpp\
    $$PWD/dialogs/indexdialog.cpp\
    $$PWD/sqlview.cpp\
    $$PWD/dialogs/triggerdialog.cpp\
    $$PWD/dialogs/triggercolumnsdialog.cpp\
    $$PWD/dbobjectdialogs.cpp\
    $$PWD/common/fontedit.cpp\
    $$PWD/configwidgets/styleconfigwidget.cpp\
    $$PWD/common/colorbutton.cpp\
    $$PWD/formmanager.cpp\
    $$PWD/configwidgets/combodatawidget.cpp\
    $$PWD/dialogs/ddlpreviewdialog.cpp\
    $$PWD/windows/ddlhistorywindow.cpp\
    $$PWD/common/userinputfilter.cpp\
    $$PWD/datagrid/sqlqueryrownummodel.cpp\
    $$PWD/windows/functionseditor.cpp\
    $$PWD/windows/functionseditormodel.cpp\
    $$PWD/sqlitesyntaxhighlighter.cpp\
    $$PWD/windows/collationseditor.cpp\
    $$PWD/selectabledbmodel.cpp\
    $$PWD/windows/collationseditormodel.cpp\
    $$PWD/qtscriptsyntaxhighlighter.cpp\
    $$PWD/icon.cpp\
    $$PWD/configmapper.cpp\
    $$PWD/dialogs/exportdialog.cpp\
    $$PWD/dbobjlistmodel.cpp\
    $$PWD/common/verifiablewizardpage.cpp\
    $$PWD/selectabledbobjmodel.cpp\
    $$PWD/common/widgetstateindicator.cpp\
    $$PWD/configwidgets/listtostringlisthash.cpp\
    $$PWD/dialogs/versionconvertsummarydialog.cpp\
    $$PWD/sqlcompareview.cpp\
    $$PWD/dialogs/errorsconfirmdialog.cpp\
    $$PWD/dialogs/sortdialog.cpp\
    $$PWD/dialogs/importdialog.cpp\
    $$PWD/dialogs/populatedialog.cpp\
    $$PWD/dialogs/populateconfigdialog.cpp\
    $$PWD/common/configradiobutton.cpp\
    $$PWD/uiloader.cpp\
    $$PWD/common/fileedit.cpp\
    $$PWD/uiscriptingcombo.cpp\
    $$PWD/uiscriptingedit.cpp\
    $$PWD/uicustomicon.cpp\
    $$PWD/uiurlbutton.cpp\
    $$PWD/common/configcombobox.cpp\
    $$PWD/dialogs/dbconverterdialog.cpp\
    $$PWD/dialogs/dbdialog.cpp\
    $$PWD/uidebug.cpp\
    $$PWD/debugconsole.cpp\
    $$PWD/common/extactionprototype.cpp\
    $$PWD/dialogs/aboutdialog.cpp\
    $$PWD/dialogs/newversiondialog.cpp\
    $$PWD/dialogs/quitconfirmdialog.cpp\
    $$PWD/common/datawidgetmapper.cpp\
    $$PWD/dialogs/languagedialog.cpp\
    $$PWD/common/ipvalidator.cpp\
    $$PWD/dialogs/cssdebugdialog.cpp\
    $$PWD/themetuner.cpp\
    $$PWD/dialogs/indexexprcolumndialog.cpp\
    $$PWD/common/centerediconitemdelegate.cpp\
    $$PWD/datagrid/sqlviewmodel.cpp\
    $$PWD/common/exttableview.cpp\
    $$PWD/common/exttablewidget.cpp\
    $$PWD/windows/sqliteextensioneditor.cpp\
    $$PWD/windows/sqliteextensioneditormodel.cpp\
    $$PWD/dialogs/bindparamsdialog.cpp\
    $$PWD/dialogs/execfromfiledialog.cpp\
    $$PWD/dialogs/fileexecerrorsdialog.cpp

HEADERS  +=\
    $$PWD/mainwindow.h\
    $$PWD/iconmanager.h\
    $$PWD/dbtree/dbtreemodel.h\
    $$PWD/dbtree/dbtreeitem.h\
    $$PWD/dbtree/dbtree.h\
    $$PWD/dbtree/dbtreeview.h\
    $$PWD/actionentry.h\
    $$PWD/uiutils.h\
    $$PWD/dbtree/dbtreeitemdelegate.h\
    $$PWD/dbtree/dbtreeitemfactory.h\
    $$PWD/sqleditor.h\
    $$PWD/datagrid/sqlquerymodel.h\
    $$PWD/dblistmodel.h\
    $$PWD/mdiarea.h\
    $$PWD/statusfield.h\
    $$PWD/common/tablewidget.h\
    $$PWD/datagrid/sqlqueryitem.h\
    $$PWD/datagrid/sqlqueryview.h\
    $$PWD/datagrid/sqlquerymodelcolumn.h\
    $$PWD/datagrid/sqlqueryitemdelegate.h\
    $$PWD/common/extlineedit.h\
    $$PWD/common/intvalidator.h\
    $$PWD/common/widgetcover.h\
    $$PWD/mdiwindow.h\
    $$PWD/mdichild.h\
    $$PWD/taskbar.h\
    $$PWD/multieditor/multieditor.h\
    $$PWD/multieditor/multieditorwidgetplugin.h\
    $$PWD/multieditor/multieditorwidget.h\
    $$PWD/widgetresizer.h\
    $$PWD/multieditor/multieditortext.h\
    $$PWD/multieditor/multieditornumeric.h\
    $$PWD/common/numericspinbox.h\
    $$PWD/multieditor/multieditordatetime.h\
    $$PWD/multieditor/multieditordate.h\
    $$PWD/multieditor/multieditortime.h\
    $$PWD/formview.h\
    $$PWD/multieditor/multieditorbool.h\
    $$PWD/multieditor/multieditorhex.h\
    $$PWD/qhexedit2/xbytearray.h\
    $$PWD/qhexedit2/qhexedit_p.h\
    $$PWD/qhexedit2/qhexedit.h\
    $$PWD/qhexedit2/commands.h\
    $$PWD/multieditor/multieditordialog.h\
    $$PWD/completer/completerwindow.h\
    $$PWD/completer/completermodel.h\
    $$PWD/completer/completeritemdelegate.h\
    $$PWD/completer/completerview.h\
    $$PWD/dialogs/searchtextdialog.h\
    $$PWD/searchtextlocator.h\
    $$PWD/windows/tablewindow.h\
    $$PWD/windows/editorwindow.h\
    $$PWD/datagrid/sqltablemodel.h\
    $$PWD/dataview.h\
    $$PWD/windows/tablestructuremodel.h\
    $$PWD/windows/tableconstraintsmodel.h\
    $$PWD/dialogs/columndialog.h\
    $$PWD/dialogs/columndialogconstraintsmodel.h\
    $$PWD/common/extaction.h\
    $$PWD/common/extactioncontainer.h\
    $$PWD/constraints/tableprimarykeypanel.h\
    $$PWD/constraints/constraintpanel.h\
    $$PWD/constraints/tableforeignkeypanel.h\
    $$PWD/constraints/tableuniquepanel.h\
    $$PWD/constraints/tablepkanduniquepanel.h\
    $$PWD/constraints/tablecheckpanel.h\
    $$PWD/constraints/columncheckpanel.h\
    $$PWD/constraints/constraintcheckpanel.h\
    $$PWD/constraints/columnforeignkeypanel.h\
    $$PWD/constraints/columnprimarykeypanel.h\
    $$PWD/constraints/columnuniquepanel.h\
    $$PWD/constraints/columnuniqueandnotnullpanel.h\
    $$PWD/constraints/columnnotnullpanel.h\
    $$PWD/constraints/columncollatepanel.h\
    $$PWD/constraints/columndefaultpanel.h\
    $$PWD/dialogs/constraintdialog.h\
    $$PWD/dialogs/newconstraintdialog.h\
    $$PWD/windows/constrainttabmodel.h\
    $$PWD/dialogs/messagelistdialog.h\
    $$PWD/windows/viewwindow.h\
    $$PWD/uiconfig.h\
    $$PWD/dialogs/indexdialog.h\
    $$PWD/sqlview.h\
    $$PWD/dialogs/triggerdialog.h\
    $$PWD/dialogs/triggercolumnsdialog.h\
    $$PWD/dbobjectdialogs.h\
    $$PWD/common/fontedit.h\
    $$PWD/customconfigwidgetplugin.h\
    $$PWD/configwidgets/styleconfigwidget.h\
    $$PWD/common/colorbutton.h\
    $$PWD/formmanager.h\
    $$PWD/configwidgets/combodatawidget.h\
    $$PWD/dialogs/ddlpreviewdialog.h\
    $$PWD/windows/ddlhistorywindow.h\
    $$PWD/common/userinputfilter.h\
    $$PWD/datagrid/sqlqueryrownummodel.h\
    $$PWD/windows/functionseditor.h\
    $$PWD/windows/functionseditormodel.h\
    $$PWD/syntaxhighlighterplugin.h\
    $$PWD/sqlitesyntaxhighlighter.h\
    $$PWD/windows/collationseditor.h\
    $$PWD/selectabledbmodel.h\
    $$PWD/windows/collationseditormodel.h\
    $$PWD/qtscriptsyntaxhighlighter.h\
    $$PWD/icon.h\
    $$PWD/configmapper.h\
    $$PWD/dialogs/exportdialog.h\
    $$PWD/dbobjlistmodel.h\
    $$PWD/common/verifiablewizardpage.h\
    $$PWD/selectabledbobjmodel.h\
    $$PWD/common/widgetstateindicator.h\
    $$PWD/configwidgets/listtostringlisthash.h\
    $$PWD/dialogs/versionconvertsummarydialog.h\
    $$PWD/sqlcompareview.h\
    $$PWD/dialogs/errorsconfirmdialog.h\
    $$PWD/dialogs/sortdialog.h\
    $$PWD/dialogs/importdialog.h\
    $$PWD/dialogs/populatedialog.h\
    $$PWD/dialogs/populateconfigdialog.h\
    $$PWD/common/configradiobutton.h\
    $$PWD/uiloader.h\
    $$PWD/common/fileedit.h\
    $$PWD/uiscriptingcombo.h\
    $$PWD/uiloaderpropertyhandler.h\
    $$PWD/uiscriptingedit.h\
    $$PWD/uicustomicon.h\
    $$PWD/uiurlbutton.h\
    $$PWD/common/configcombobox.h\
    $$PWD/dialogs/dbconverterdialog.h\
    $$PWD/dialogs/configdialog.h\
    $$PWD/dialogs/dbdialog.h\
    $$PWD/uidebug.h\
    $$PWD/debugconsole.h\
    $$PWD/common/extactionprototype.h\
    $$PWD/dialogs/aboutdialog.h\
    $$PWD/dialogs/newversiondialog.h\
    $$PWD/guiSQLiteStudio_global.h\
    $$PWD/dialogs/quitconfirmdialog.h\
    $$PWD/common/datawidgetmapper.h\
    $$PWD/dialogs/languagedialog.h\
    $$PWD/common/ipvalidator.h\
    $$PWD/dialogs/cssdebugdialog.h\
    $$PWD/themetuner.h\
    $$PWD/dialogs/indexexprcolumndialog.h\
    $$PWD/common/centerediconitemdelegate.h\
    $$PWD/datagrid/sqlviewmodel.h\
    $$PWD/common/exttableview.h\
    $$PWD/common/exttablewidget.h\
    $$PWD/windows/sqliteextensioneditor.h\
    $$PWD/windows/sqliteextensioneditormodel.h\
    $$PWD/dialogs/bindparamsdialog.h\
    $$PWD/common/bindparam.h\
    $$PWD/dialogs/execfromfiledialog.h\
    $$PWD/dialogs/fileexecerrorsdialog.h

FORMS    +=\
    $$PWD/mainwindow.ui\
    $$PWD/dbtree/dbtree.ui\
    $$PWD/statusfield.ui\
    $$PWD/completer/completerwindow.ui\
    $$PWD/dialogs/searchtextdialog.ui\
    $$PWD/windows/tablewindow.ui\
    $$PWD/windows/editorwindow.ui\
    $$PWD/dialogs/columndialog.ui\
    $$PWD/constraints/tableforeignkeypanel.ui\
    $$PWD/constraints/tablepkanduniquepanel.ui\
    $$PWD/constraints/constraintcheckpanel.ui\
    $$PWD/constraints/columnforeignkeypanel.ui\
    $$PWD/constraints/columnprimarykeypanel.ui\
    $$PWD/constraints/columnuniqueandnotnullpanel.ui\
    $$PWD/constraints/columncollatepanel.ui\
    $$PWD/constraints/columndefaultpanel.ui\
    $$PWD/dialogs/constraintdialog.ui\
    $$PWD/dialogs/newconstraintdialog.ui\
    $$PWD/dialogs/messagelistdialog.ui\
    $$PWD/windows/viewwindow.ui\
    $$PWD/dialogs/configdialog.ui\
    $$PWD/dialogs/indexdialog.ui\
    $$PWD/dialogs/triggerdialog.ui\
    $$PWD/dialogs/triggercolumnsdialog.ui\
    $$PWD/common/fontedit.ui\
    $$PWD/forms/sqlformatterplugin.ui\
    $$PWD/dialogs/ddlpreviewdialog.ui\
    $$PWD/windows/ddlhistorywindow.ui\
    $$PWD/windows/functionseditor.ui\
    $$PWD/windows/collationseditor.ui\
    $$PWD/dialogs/exportdialog.ui\
    $$PWD/dialogs/versionconvertsummarydialog.ui\
    $$PWD/dialogs/errorsconfirmdialog.ui\
    $$PWD/dialogs/sortdialog.ui\
    $$PWD/dialogs/importdialog.ui\
    $$PWD/dialogs/populatedialog.ui\
    $$PWD/dialogs/populateconfigdialog.ui\
    $$PWD/dialogs/dbconverterdialog.ui\
    $$PWD/dialogs/dbdialog.ui\
    $$PWD/debugconsole.ui\
    $$PWD/dialogs/aboutdialog.ui\
    $$PWD/dialogs/newversiondialog.ui\
    $$PWD/dialogs/quitconfirmdialog.ui\
    $$PWD/dialogs/languagedialog.ui\
    $$PWD/dialogs/cssdebugdialog.ui\
    $$PWD/dialogs/indexexprcolumndialog.ui\
    $$PWD/windows/sqliteextensioneditor.ui\
    $$PWD/dialogs/bindparamsdialog.ui\
    $$PWD/dialogs/execfromfiledialog.ui\
    $$PWD/dialogs/fileexecerrorsdialog.ui

RESOURCES +=\
    $$PWD/icons.qrc\
    $$PWD/guiSQLiteStudio.qrc

OTHER_FILES +=

unix: {
    target.path = $$LIBDIR
    INSTALLS += target
}

# LIBS += -lcoreSQLiteStudio

DISTFILES +=\
    general.css
















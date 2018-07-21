# allows to add DEPLOYMENTFOLDERS and links to the V-Play library and QtCreator auto-completion
CONFIG += v-play

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://v-play.net/custom-code-reload-app/
#CONFIG += v-play-live

# configure the bundle identifier for iOS
PRODUCT_IDENTIFIER = com.yourcompany.wizardEVAP.Music

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    server.cpp \
    client.cpp \
    musiclist.cpp \
    mydb.cpp

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST =
    OTHER_FILES += $$QMAKE_INFO_PLIST
    
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

INCLUDEPATH += /usr/include/mysql
LIBS += -L/usr/mysql -lmysqlclient_r

HEADERS += \
    client.h \
    server.h \
    musiclist.h \
    mydb.h

DISTFILES += \
    qml/pages/CSPage.qml \
    qml/pages/SelectFilePage.qml \
    qml/playmenu/Flatbutton.qml \
    qml/playmenu/MainColumn.qml \
    qml/playmenu/MainPage.qml \
    qml/playmenu/Music.qml \
    qml/playmenu/NewBorder.qml \
    qml/playmenu/Sound.qml \
    qml/pages/ChangeTheme.qml \
    qml/pages/ThemeColor.qml \
    qml/Lyrics.qml \
    qml/Fram.qml \
    qml/MainNavigationPage.qml \
    qml/playmenu/MusicListPage.qml \
    qml/playmenu/MusicPage.qml \
    qml/playmenu/AddMusicToListMenu.qml \
    qml/pages/ClientPage.qml \
    qml/pages/ServerPage.qml \
    qml/playmenu/PerferPage.qml \
    qml/playmenu/PerferList.qml

#include <VPApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QTime>
#include <QDebug>
#include <QtQuick>

#include "server.h"
#include "client.h"
#include "musiclist.h"
#include "mydb.h"


using std::string;

string DB_server = "localhost";
string DB_username = "root";
string DB_password = "";
string DB_name = "test";

int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    qmlRegisterType<Server>("server", 1, 0, "Server");
    qmlRegisterType<Client>("client", 1, 0, "Client");

    VPApplication vplay;
    vplay.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    vplay.initialize(&engine);

    vplay.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    engine.load(QUrl(vplay.mainQmlFileName()));
    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));

//    MusicList musicList;
//    musicList.run();
//    engine.rootContext()->setContextProperty("myModel", /*QVariant::fromValue(*/&musicList);

    MyDB db;
    db.initDB(DB_server, DB_username, DB_password, DB_name);
    db.readTableData();
    engine.rootContext()->setContextProperty("listModel", /*QVariant::fromValue(*/&db);

        //    QStringList dataList = musicList.list();
    //    engine.rootContext()->setContextProperty("myModel", QVariant::fromValue(dataList));


    return app.exec();
}

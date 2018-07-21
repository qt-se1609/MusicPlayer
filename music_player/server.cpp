#include <QtWidgets>
#include <QtNetwork>
#include <QTimer>
#include <stdlib.h>

#include <QFileInfo>
#include <QByteArray>

#include "server.h"

#include <fstream>
#include <iostream>
#include <string>
#include <QString>
#include <QDebug>

#define BUF_SIZE 1024*4

Server::Server(QObject *parent)
    : QObject(parent)
    , tcpServer(Q_NULLPTR)
    , networkSession(0)
{

    QNetworkConfigurationManager manager;
    if (manager.capabilities() & QNetworkConfigurationManager::NetworkSessionRequired) {
        // 配置会话
        QSettings settings(QSettings::UserScope, QLatin1String("QtProject"));
        settings.beginGroup(QLatin1String("QtNetwork"));
        const QString id = settings.value(QLatin1String("DefaultNetworkConfiguration")).toString();
        settings.endGroup();

        // If the saved network configuration is not currently discovered use the system default
        QNetworkConfiguration config = manager.configurationFromIdentifier(id);
        if ((config.state() & QNetworkConfiguration::Discovered) !=
                QNetworkConfiguration::Discovered) {
            config = manager.defaultConfiguration();
        }

        networkSession = new QNetworkSession(config, this);
        connect(networkSession, &QNetworkSession::opened, this, &Server::sessionOpened);

        networkSession->open();
    } else {
        sessionOpened();
    }

    connect(tcpServer, &QTcpServer::newConnection, this, &Server::sendConnect); //连接成功后

}

Server::~Server()
{
    qDebug() << "delete server";
    delete networkSession;
    delete tcpServer;
}


void Server::sessionOpened() // 配置会话
{
    // Save the used configuration
    if (networkSession) {
        QNetworkConfiguration config = networkSession->configuration();
        QString id;
        if (config.type() == QNetworkConfiguration::UserChoice)
            id = networkSession->sessionProperty(QLatin1String("UserChoiceConfiguration")).toString();
        else
            id = config.identifier();

        QSettings settings(QSettings::UserScope, QLatin1String("QtProject"));
        settings.beginGroup(QLatin1String("QtNetwork"));
        settings.setValue(QLatin1String("DefaultNetworkConfiguration"), id);
        settings.endGroup();
    }

    tcpServer = new QTcpServer(this);
    if (!tcpServer->listen()) { //服务器监听
        qDebug() << "listen failse";
        return;
    }
    QString ipAddress;
    QList<QHostAddress> ipAddressesList = QNetworkInterface::allAddresses();
    // use the first non-localhost IPv4 address
    for (int i = 0; i < ipAddressesList.size(); ++i) {
        if (ipAddressesList.at(i) != QHostAddress::LocalHost &&
                ipAddressesList.at(i).toIPv4Address()) {
            ipAddress = ipAddressesList.at(i).toString();
            break;
        }
    }
    // if we did not find one, use IPv4 localhost
    if (ipAddress.isEmpty())
        ipAddress = QHostAddress(QHostAddress::LocalHost).toString();

    m_ip = ipAddress; //得到本机的IP
    m_port = tcpServer->serverPort(); //得到本机的port
}

void Server::sendConnect()
{
    clientConnection = tcpServer->nextPendingConnection();
    if(clientConnection){
        qDebug() << "connect succeede";
        connectSucceeded(); //连接成功
    }
    connect(clientConnection, &QTcpSocket::readyRead, this, &Server::onRead); //连接成功后发送连接
    connect(clientConnection, &QAbstractSocket::disconnected,
            clientConnection, &QObject::deleteLater); //断开连接后销毁
}

void Server::onRead()
{
    QByteArray buf = clientConnection->readAll();

    if("FileHead recv" == QString(buf)){ //收到客户端连接成功的消息
        sendData();
    }
    else if("file write done" == QString(buf)){ //收到客户端接受完毕的消息
        qDebug() << "send succeeded";
        file.close();
        clientConnection->disconnectFromHost();
        clientConnection->close();
    }
}

void Server::sendData()
{
    qint64 len = 0;
    do{
        char buf[BUF_SIZE] = {0};          //一次发送的大小
        len = 0;
        len = file.read(buf,BUF_SIZE);  //len为读取的字节数
        len = clientConnection->write(buf,len);    //len为发送的字节数
        //sendSize += len; //已发数据累加
    }while(len > 0);
}

void Server::sendHead()
{
    QString head = QString("%1##%2").arg(fileName).arg(fileSize);
    //发送头部信息
    qint64 len = clientConnection->write(head.toUtf8());

    if(len < 0){
        qDebug() << "send head fail";
        file.close();
    }
    qDebug() << "send file succeede"; //文件传输成功
}

void Server::openFile(QString selectFile)
{

    QString filePath = selectFile;
    qDebug() << "open file: " << filePath;
    if(false == filePath.isEmpty()){    //路径有效
        fileName.clear();
        fileSize = 0;
        QFileInfo info(filePath); //获取文件信息：名字、大小
        fileName = info.fileName();
        fileSize = info.size();
        //sendSize = 0;   //已经发送文件大小

        //以只读方式打开文件
        file.setFileName(filePath);
        if(false == file.open(QFileDevice::ReadOnly | QIODevice::Text)){
            qDebug() << "open false " << filePath;
        }
        else{
            qDebug() << "open this" << filePath;
            emit selectSucceeded(); //已经打开的文件路径
        }
    }
    else{
        qDebug() <<"path is bad"; //文件打开失败
    }
}

QString Server::ip() const
{
    return m_ip;
}

quint16 Server::port() const
{
    return m_port;
}



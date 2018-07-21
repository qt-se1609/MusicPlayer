#include <QtWidgets>
#include <QtNetwork>
#include <QTcpSocket>
#include <QDataStream>

#include "client.h"

QString receivePath{"/root"};

Client::Client(QObject *parent)
    : QObject(parent)
    , tcpSocket(new QTcpSocket(this))
    , networkSession(Q_NULLPTR)
{
    connect(tcpSocket, &QTcpSocket::readyRead, this, &Client::onRead);  //接受文件


    QNetworkConfigurationManager manager; //配置会话
    if (manager.capabilities() & QNetworkConfigurationManager::NetworkSessionRequired) {
        // Get saved network configuration
        QSettings settings(QSettings::UserScope , QLatin1String("QtProject"));
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
        connect(networkSession, &QNetworkSession::opened, this, &Client::sessionOpened);

        networkSession->open();
    }
}

Client::~Client()
{
    qDebug() << "delete client";
    delete networkSession;
}

void Client::requestNewconnect() //请求一个新的连接
{
    tcpSocket->abort();
    tcpSocket->connectToHost(m_ip, m_port);

    isStart = true;
}

void Client::onRead()
{
    QByteArray buf = tcpSocket->readAll();

    if(true == isStart){
        qDebug() << "send head ";
        isStart = false;
        //接收文件头
        fileName = QString(buf).section("##",0,0);
        fileSize = QString(buf).section("##",1,1).toInt();
        recvSize = 0;
        QString str = QString("接收的文件:[%1:%2kB]").arg(fileName).arg(fileSize/1024);

        qDebug() << "file message: " << str;

        fileName = receivePath + fileName;
        file.setFileName(fileName);
        if(false == file.open(QIODevice::WriteOnly)){
            qDebug() << "file creat fails: " << fileName;
        }
        else
            qDebug() << "creat file " << fileName;
        tcpSocket->write("FileHead recv");
    }else{
        //接收处理文件
        qint64 len = file.write(buf);
        recvSize += len;

        if(recvSize == fileSize){//接收完毕
            emit connectSucceeded();
            qDebug() << "receive succeeded";
            file.close();
            tcpSocket->write("file write done"); //返回接受完毕
            tcpSocket->disconnectFromHost();
            tcpSocket->close();
        }
    }
}

void Client::sessionOpened()
{
    // Save the used configuration
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

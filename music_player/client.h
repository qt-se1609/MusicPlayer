#ifndef CLIENT_H
#define CLIENT_H

//接收方 周敏

#include <QObject>
#include <QFile>

class QTcpSocket;
class QNetworkSession;
class QFile;

class Client : public QObject
{
    Q_OBJECT

public:

    Q_INVOKABLE void getIpAndPort(QString ip, QString port){
        // 得到输入的ip 和 port
        m_ip = ip;
        m_port = port.toInt();
        requestNewconnect(); //请求连接
    }
    explicit Client(QObject *parent = Q_NULLPTR);
    ~Client();
signals:
    void connectSucceeded(); //连接成功

private slots:
    void requestNewconnect();  //请求连接
    void onRead();  //接受文件
    void sessionOpened();  //会话打开

private:
    bool isStart;   //标志是否连接

    QTcpSocket *tcpSocket;  //通信
    QFile file;             //文件对象
    QString fileName;       //文件名字
    qint64 fileSize;        //文件大小
    qint64 recvSize;        //已经发送大小

    QString m_ip;            //主机ip
    quint16 m_port;          //主机port

    QNetworkSession *networkSession; //管理会话
};


#endif // CLIENT_H

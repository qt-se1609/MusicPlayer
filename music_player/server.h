#ifndef SERVER_H
#define SERVER_H
//接收方 周敏
#include <QObject>
#include <QFile>

class QTcpServer;
class QTcpSocket;
class QFile;
class QNetworkSession;
class QString;

class Server : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString ip READ ip)
    Q_PROPERTY(quint16 port READ port)

public:

    Q_INVOKABLE void openFile(QString selectFile); //打开文件
    Q_INVOKABLE void sendHead();  //发送文件头

    explicit Server(QObject *parent = Q_NULLPTR);
    ~Server();

    quint16 port() const;  //得到本机ip
    QString ip() const; //得到本机port

signals:
    void connectSucceeded(); //连接成功
    void selectSucceeded();  //选择文件成功

private slots:
    void onRead();

private:
    void sessionOpened();  //打开会话
    void sendConnect();
    void sendData();    //发送文件数据

    QString m_ip;       //本机ip
    quint16 m_port;     //本机port

    QTcpServer * tcpServer; //监听
    QTcpSocket * clientConnection; //通信
    QFile file;             //文件对象
    QString fileName;       //文件名字
    qint64 fileSize;        //文件大小
    qint64 sendSize;        //已经发送大小
    QNetworkSession *networkSession;  //管理会话



};

#endif // SERVER_H

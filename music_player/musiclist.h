#ifndef MUSICLIST_H
#define MUSICLIST_H

//读取系统中全部音乐 田益兰

#include <QStringList>
#include <QObject>
#include <QDir>
#include <QDirIterator>
#include <QString>
#include <QThread>
#include <QMutex>
#include <map>
#include <QDebug>

class MusicList : public QThread
{
    Q_OBJECT
    Q_PROPERTY(QStringList list READ list NOTIFY listChanged)

public:
//    Q_INVOKABLE void append(QString s){
//        m_list.append(s);
//    }
    MusicList(QObject *parent = 0);
    ~MusicList();

//    Q_PROPERTY(QJsonArray playlist READ playlist NOTIFY playlistChanged)
//    QJsonArray playlist();

    Q_INVOKABLE void findMusic();

    Q_INVOKABLE int getItemsLength(){
        return musicPath.count();
    }
    Q_INVOKABLE QString getMusicName(int id){
        return musicPath.at(id).fileName();
    }
    Q_INVOKABLE QString getMusicPath(int id){
        qDebug() << "root path";
        return musicPath.at(id).filePath();
    }
    Q_INVOKABLE void run();
    Q_INVOKABLE bool noEnd(int id){
        return id != (musicPath.count() - 1);
    }

    QStringList list() const;

signals:
    void listChanged();
    void playlistChanged();

private:
    QStringList m_list;
    QList<QFileInfo> musicPath;
};

#endif // MUSICLIST_H

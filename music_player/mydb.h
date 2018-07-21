#ifndef MYDB_H
#define MYDB_H

//存储音乐清单到数据库 田益兰 周敏
#include <QObject>
#include <mysql.h>
#include <string>
#include <QStringList>
#include <QFileInfo>
#include <map>
#include "musiclist.h"

class MyDB : public QObject
{
    //田益兰
    Q_OBJECT
    Q_PROPERTY(QStringList perferMusicList READ perferMusicList)
//    Q_PROPERTY(QStringList perferMusicPathList READ perferMusicPathList)
    Q_PROPERTY(QStringList rootList READ rootList)

public:
    MyDB();
    ~MyDB();
    bool initDB(std::string host, std::string user, std::string pwd, std::string db_name);
    bool readTableData();
    Q_INVOKABLE bool addMusic(QString data);
    Q_INVOKABLE  bool deleteMusic(QString data);

    Q_INVOKABLE QString getMusicPath(QString listName, int id);
    Q_INVOKABLE QString getMusicName(QString listName, int id);
    Q_INVOKABLE bool noEnd(QString listName , int n);
    Q_INVOKABLE int getListLength(QString listName );

    QStringList rootList() const;
    QStringList perferMusicList() const;
    //Q_INVOKABLE QStringList getMusicList() const;

signals:
        void perferMusicListChange();

private:
    std::string music(std::string data);
    MYSQL *mysql;//连接mysql句柄指针
    MYSQL_RES *result;//指向查询结果的指针
    MYSQL_ROW row;//返回行信息
    QStringList m_perferMusicList; //最喜欢的音乐
    QStringList m_perferMusicPathList;

    QStringList m_rootList; //系统音乐歌单路径
    MusicList m_rootMusic; //系统音乐歌单

//田益兰

//周敏
public:
    Q_PROPERTY(QStringList list READ list)
    Q_PROPERTY(QStringList musics READ musics)

    Q_INVOKABLE void addMusicList(QString listName); //添加一个歌单
    Q_INVOKABLE void currentMusicList(QString listName); //得到歌单列表
    Q_INVOKABLE void addMusicToList(QString listName,
                                    /*QString musicName, */QString musicPath); //向歌单中添加一首歌曲
    Q_INVOKABLE void deleteMusicList(QString listName, int n); //删除一个歌单
    Q_INVOKABLE void deleteMusicFromList(QString listName, int index); //删除歌单中的一首歌
    Q_INVOKABLE QString getPath(QString listName, int index); //得到歌曲路径

    QStringList list() const;

    QStringList musics() const;

private:
    QStringList m_list; //歌单列表
    QStringList m_musics; //当前歌单歌曲列表
    std::map<QString, QStringList> m_musicList; //歌曲路径列表
//周敏
};

#endif // MYDB_H

#include "mydb.h"
#include <mysql/mysql.h>
#include <QDebug>

//田益兰
MyDB::MyDB()
{
    mysql = mysql_init(NULL);//初始化数据库
    if(mysql == NULL)
    {
        //        QDebug() << "Error: 初始化失败";
        exit(1);
    }
}

MyDB::~MyDB()
{
    if(mysql!=NULL)//关闭数据连接
    {
        mysql_close(mysql);
    }
}


bool MyDB::initDB(std::string host,std::string user,std::string passwd,std::string db_name)
{
    //建立一个数据库连接
    mysql = mysql_real_connect(mysql, host.c_str(), user.c_str(), passwd.c_str(), db_name.c_str(), 0, NULL, 0);
    if(mysql == NULL)
    {
        qDebug() << "Error: 连接数据库失败 "/* << mysql_error(mysql)*/;
        exit(1);
    }
    return true;
}

bool MyDB::readTableData()//读取数据库中的信息
{
    m_rootMusic.run();
    m_rootList = m_rootMusic.list();// 得到系统音乐歌单

    //从数据库中读取“最喜爱的音乐”歌单信息
    m_perferMusicList.clear();
    m_perferMusicPathList.clear();
    std::string sql = "select * from musicPath";
    mysql_query(mysql, sql.c_str());
    auto sresult = mysql_store_result(mysql);//获取结果集
    if (sresult){
        int num_rows = mysql_num_rows(sresult);//获取结果集中总共的行数
        for(int i=0;i<num_rows;i++)
        {
            auto row = mysql_fetch_row(sresult);//获取结果集中的列
            if(!row) break;
            m_perferMusicList.append(QString::fromStdString(music(row[0])));
            m_perferMusicPathList.append(QString::fromStdString(row[0]));
            //            QDebug() << row[0] /*<< " " << row[1]*/;
            //            QDebug() << endl;
        }
    }else {
        qDebug() << "Error: perfer读取表";
        return false;
    }

    //从数据库钟读取自定义歌单信息
    std::string sql1 = "select * from musicListPath";
    mysql_query(mysql, sql1.c_str());
    auto sresult1 = mysql_store_result(mysql);//获取结果集
    if (sresult1){
        int num_rows = mysql_num_rows(sresult1);//获取结果集中总共的行数
        for(int i=0;i<num_rows;i++)
        {
            auto row = mysql_fetch_row(sresult1);//获取结果集中的列
            if(!row) break;
            auto musicPath = QString::fromStdString(row[1]);
            auto listName = QString::fromStdString(row[0]);
            //读取歌单
            if(m_musicList.find(listName) == m_musicList.end()){
                //如果歌单不存在
                QStringList list;
                m_list.append(listName);
                m_musicList.insert(std::pair<QString, QStringList >(listName, list));
            } else if(musicPath != ""){
                //歌单存在且 如果路径有效
                m_musicList[listName].append(musicPath);//读取歌单中的音乐路径
            }
        }
    }else {
        qDebug() << "Error: list读取表";
        return false;
    }


    return true;
}

bool MyDB::addMusic(QString data)//添加音乐
{
    std::string sql = "insert ignore musicPath values('" + data.toStdString() + "')";
    //    qDebug() << "TTTTT";
    if (0 != mysql_query(mysql, sql.c_str()))
    {
        //        QDebug() << "Query Error: 添加失败";
        return false;
    }
    m_perferMusicPathList.append(data);
    m_perferMusicList.append(QString::fromStdString(music(data.toStdString())));
    return true;
}

bool MyDB::deleteMusic(QString data)//删除音乐
{
    std::string sql = "delete from musicPath where pathName in('"+data.toStdString()+"')";
    if (0 != mysql_query(mysql, sql.c_str()))
    {
        //        QDebug() << "Query Error: 删除失败";
        return false;
    }
    readTableData();
    return true;
}

QString MyDB::getMusicPath(QString listName, int id)
{
    qDebug() << "get music path" << listName << ";";
    if(listName == "perfer"){
        qDebug() << m_perferMusicPathList.at(id);
        return m_perferMusicPathList.at(id);
    } else if(listName == ""){
        qDebug() << m_rootMusic.getMusicPath(id);
        return m_rootMusic.getMusicPath(id);
    } else {
        return getPath(listName, id);
    }
}

QString MyDB::getMusicName(QString listName, int id)
{
    qDebug() << "get misic name" << listName << ";";
    if(listName == "perfer"){
        return m_perferMusicList.at(id);
    } else if(listName == ""){
        return m_rootList.at(id);
    } else {
        return m_musics.at(id);
    }
}

bool MyDB::noEnd(QString listName, int n)
{
    if(listName == "perfer"){
        return n != (m_perferMusicList.count() - 1);
    } else if(listName == "") {
        return n != (m_rootList.count() - 1);
    } else {
        return n != (m_musicList[listName].count() - 1);
    }
}

int MyDB::getListLength(QString listName)
{
    if(listName == "perfer"){
        return m_perferMusicList.count();
    } else if(listName == "") {
        return m_rootList.count();
    } else {
        return m_musicList[listName].count();
    }
}

QStringList MyDB::perferMusicList() const// //最喜欢的音乐列表
{
    return m_perferMusicList;
}

std::string MyDB::music(std::string data){//从路径中提取音乐名字
    std::string::iterator cbegin, cend;
    auto end = data.end();
    while (end != data.begin()) {
        end--;
        //        QDebug() << *end;
        if(*end == '.')
            cend = end;
        else if(*end == '/'){
            cbegin = end;
            cbegin++;
            std::string mu = std::string(cbegin, cend);
            //            m_music.push_back(mu);
            //            QDebug() << mu;
            return mu;
        }
    }
    return "";
}

QStringList MyDB::rootList() const
{
    return m_rootList;
}
//田益兰

//周敏
void MyDB::addMusicList(QString listName) //添加歌单
{
    QStringList list;
    auto it = m_musicList.find(listName);
    if(listName != "perfer"){
        if(it != m_musicList.end()){
            qDebug() << "list name exist ";
        } else{
            std::string sql = "insert ignore musicListPath values('" + listName.toStdString() + "', '')";
            if (0 != mysql_query(mysql, sql.c_str()))
            {
                qDebug() << "Query Error: list添加失败";
                return;
            }

            m_list.append(listName);
            m_musicList.insert(std::pair<QString, QStringList >(listName, list));
            //qDebug() << listName;
        }
    }
    else qDebug() <<"perfer exist";
}

void MyDB::currentMusicList(QString listName) //得到歌单歌曲
{
    m_musics.clear();
    QStringList musicPath = m_musicList[listName];
    for(QString &s: musicPath){
        std::string path = music(s.toStdString());
        m_musics.append(QString::fromStdString(path));
    }
    //return m_music;
}

void MyDB::addMusicToList(QString listName, /*QString musicName, */QString musicPath) //添加歌曲到歌单
{
    if(musicPath != ""){
        std::string sql = "insert ignore musicListPath values('" +
                listName.toStdString() + "','" + musicPath.toStdString() + "')";
        if (0 != mysql_query(mysql, sql.c_str()))
        {
            qDebug() << "Query Error: path添加失败";
            return;
        }
        auto list = m_musicList[listName];
        for(auto & s: list){
            if(s == musicPath){
                qDebug() << "music exist";
                return;
            }
        }
        m_musicList[listName].append(musicPath);
    }

}

void MyDB::deleteMusicList(QString listName, int n) //删除歌单
{
    qDebug() << "delete" << n << listName;
    for(auto s: m_list){
        if(s == listName){
            std::string sql = "delete from musicListPath where listName in('"+listName.toStdString()+"')";
            if (0 != mysql_query(mysql, sql.c_str()))
            {
                qDebug() << "Query Error: list删除失败";
                return ;
            }
            m_list.removeAt(n);
            m_musicList.erase(listName);
        }
    }
}

void MyDB::deleteMusicFromList(QString listName, int index) //从歌单中删除歌曲
{
    auto musicPath = m_musicList[listName].at(index);
    qDebug() << "delete: " << listName << musicPath;
    std::string sql = "delete from musicListPath where listName='" + listName.toStdString() +
            "' and musicPath='" + musicPath.toStdString() + "'";
    if (0 != mysql_query(mysql, sql.c_str()))
    {
        qDebug() << "Query Error: music删除失败";
        return;
    }
    m_musicList[listName].removeAt(index);
    currentMusicList(listName);
}

QString MyDB::getPath(QString listName, int index) //得到音乐的路径
{
    return m_musicList[listName].at(index);
}

QStringList MyDB::list() const //得到歌单列表
{
    return m_list;
}

QStringList MyDB::musics() const //当前歌单歌曲列表
{
    return m_musics;
}
//周敏

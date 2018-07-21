#include "musiclist.h"
#include <QDebug>

MusicList::MusicList(QObject *parent) : QThread(parent)
{}

MusicList::~MusicList()
{}

void MusicList::findMusic(){
    this->start();
}

void MusicList::run()
{
    QMutex mutex;
    mutex.lock();

    QStringList filters;
    filters<<QString("*.mp3");

    musicPath.clear();

    QDirIterator dir_iterator("/root", filters, QDir::Files | QDir::NoSymLinks,QDirIterator::Subdirectories);
    while(dir_iterator.hasNext())
    {
        dir_iterator.next();
        musicPath.append(dir_iterator.fileInfo());
        m_list.append(dir_iterator.fileInfo().fileName());
    }
    mutex.unlock();
    playlistChanged();
//    qDebug() << "ddddd";
}

QStringList MusicList::list() const
{
    return m_list;
}


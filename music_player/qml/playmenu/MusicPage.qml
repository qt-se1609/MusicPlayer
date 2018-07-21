import QtQuick 2.0
import VPlayApps 1.0

//周敏 显示歌单中的歌曲， 删除歌单中的歌曲
Page {
    id: musicPage
    title: listName

    property var listDataModel: listModel.musics  //歌单列表

    AppListView {
        //自己喜欢的音乐到我的音乐列表
        id: musicView
        width: parent.width
        //        model: musicListPage.listDataModel
        model: musicPage.listDataModel
        delegate: SimpleRow {
            text: modelData
            onSelected: {
                currentIndex = index
                musicName = text
                console.log(text)
                musicPath = listModel.getMusicPath(listName, currentIndex)
                musicName = listModel.getMusicName(listName, currentIndex)
                startButton = "暂停"
                //deleteBottom.enabled = true
            }
        }
    }

    Row{
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Flatbutton{ //删除歌单中的歌曲
            id: del
            width: 100
            height: 50
            anchors.bottom: parent.bottom
            Text {
                text: qsTr("Delete Music")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                listModel.deleteMusicFromList(listName, currentIndex)
                musicPage.listDataModel.push()
                musicPage.listDataModelChanged()

                //listModel.deleteMusic(musicPath)
            }
        }
        Flatbutton{ //删除歌单
            id: delList
            width: 100
            height: 50
            anchors.bottom: parent.bottom
            Text {
                text: qsTr("Delete List")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                //listModel.deleteMusicFromList(listName, currentIndex)
                listModel.deleteMusicList(listName, listIndex)
                //console.log("delete ",listName)
                childNavigationStack.pop(list)
                page.dataModelChanged()
                //page.dataModelpush()
                popped()
            }
        }

    }

}

import QtQuick 2.0
import VPlayApps 1.0
import "playmenu"

//框架 周敏
Item {
    property string musicName: "系统音乐"
    property string musicPath
    property string startButton: "开始"
    property int currentIndex
    property string listName: "" //被选择歌单名

    property bool stop: true
    anchors.fill: parent
    Rectangle { //功能页
        id: musicLtstRec
        height: (parent.height * 10) / 11
        width: parent.width / 4
        anchors.left: parent.left
        MainNavigationPage {
        }
    }
    Rectangle { //歌词页
        id: lyriceRec
        height: (parent.height * 10) / 11
        width: (parent.width * 3) / 4
        anchors.right: parent.right
        Lyrics {
        }
    }
    Rectangle { //播放功能键
        id: playRec
        width: parent.width
        height: parent.height / 11
        anchors.bottom: parent.bottom
        Music {
            id: play
            anchors.fill: parent
        }
    }
    Rectangle{ //添加歌曲到歌单
        id: listMenu
        width: 200
        height: musicLtstRec.height/2
        anchors.bottom: playRec.top
        anchors.left: musicLtstRec.right
        visible: false
        border.color: mainColor
        border.width: 2
        AddMusicToListMenu{
            //id: addListPage
        }
    }
}

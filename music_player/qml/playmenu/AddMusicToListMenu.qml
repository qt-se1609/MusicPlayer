import QtQuick 2.0
import VPlayApps 1.0

//周敏 添加歌曲到歌单
Page{
    id: addListPage
    width: parent.width
    property var listMenuModel: listModel.list

    AppListView {
        //自己喜欢的音乐到我的音乐列表
        id: addMune
        width: parent.width
        model: addListPage.listMenuModel
        delegate: SimpleRow {
            text: modelData
            onSelected: {
                console.log("add menu" ,text)
                listModel.addMusicToList(text, musicPath) // (歌单名， 歌曲路径)
                listMenu.visible = false;
               // listMenu.enabled = false;
            }
        }
    }

    Flatbutton {//更新列表
        id: updataListButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 100
        Text {
            text: qsTr("Updata List")
            anchors.centerIn: parent
            color: colorfont
        }
        onClicked: {
            addListPage.listMenuModel.push()
            addListPage.listMenuModelChanged()
        }
    }

}

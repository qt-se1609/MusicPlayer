import VPlayApps 1.0
import QtQuick 2.1

//周敏 添加歌单
Page {
    id: page
    title: "Add Music List"

    // the data model for the list
    property var dataModel: listModel.list //歌单列表

    property int listIndex //被选择歌单索引
    property string newListName:inputName.text //新建歌单的名字

    // list view
    AppListView {
        id: misicListView
        anchors.top: parent.top
        anchors.bottom: listBotton.top
        width: parent.width
        model: page.dataModel //歌单列表
        delegate: SimpleRow {
            text: modelData
            onSelected: {
                listIndex = index //被选择歌单的索引
                listName = text //被选择歌单的名字

                listModel.currentMusicList(text)
                //myListModel = listModel.getMusicList(text) //得到选择歌单的歌曲列表
                childNavigationStack.popAllExceptFirstAndPush(list)
            }
        }
    }

    Row{
        id: listBotton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.leftMargin: 50
        AppTextField { //输入歌单名字
            id: inputName
            anchors.bottom: parent.bottom
            width: parent.width/2
            borderColor: mainColor
            borderWidth: 3
            focus: false
            onTextChanged: {
                add.enabled = true
                add.opacity = 1
            }
        }
        Flatbutton{
            id: add //添加歌单
            width: 100
            height: 50
            anchors.bottom: parent.bottom
            enabled: false
            opacity: 0.5
            Text {
                text: qsTr("Add List")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                listModel.addMusicList(newListName) //添加一个新的歌单
                add.enabled = false
                add.opacity = 0.5
                inputName.text = ""
                page.dataModel.push()
                page.dataModelChanged()
            }
        }

        Flatbutton{ //更新列表
            id: del
            width: 100
            height: 50
            anchors.bottom: parent.bottom
            Text {
                text: qsTr("Updata List")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                page.dataModel.push()
                page.dataModelChanged()
            }
        }
    }



    property Component list: MusicPage{
    }

}

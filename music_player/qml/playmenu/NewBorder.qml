import QtQuick 2.0
import QtQuick.Window 2.2
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2


//功能键 李楷 田益兰
Rectangle {
    id: p
    //    color: "#0080FF"
    border.width: 0
    height: 30

    MouseArea {
        anchors.fill: parent
    }

    property bool end: false
    Row {
        id: cont
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 5

        Flatbutton { //田益兰
            id: b

            Text {
                id: na
                text: qsTr("上一曲")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                if (currentIndex) {
                    currentIndex--
                    //                console.log(myModel.getMusicPath(currentIndex))
                    //                console.log(myModel.getMusicName(currentIndex))
                } else {
                    currentIndex = listModel.getListLength(listName ,currentIndex) - 1
                }
                musicName = listModel.getMusicName(listName ,currentIndex)
                player.source = listModel.getMusicPath(listName ,currentIndex)

            }
        }

        Flatbutton { //田益兰
            Text {
                id: nam
                text: qsTr("下一曲")
                anchors.centerIn: parent
                color: colorfont
            }

            onClicked: {
                if(listModel.noEnd(listName, currentIndex)){
                    currentIndex++
                } else {
                    currentIndex = 0
                }
                musicName = listModel.getMusicName(listName ,currentIndex)
                player.source = listModel.getMusicPath(listName ,currentIndex)
            }
        }


        Flatbutton {
            Text {
                id: start
                text: startButton
                anchors.centerIn: parent
                color: colorfont
            }
            property int i: 0
            onClicked: {
                if (stop) {
                    player.play()
                    start.text = "暂停"
                    stop = false
                } else {
                    player.pause()
                    start.text = "开始"
                    stop = true
                }
            }
        }


        Flatbutton {
            Text {
                text: qsTr("停止")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                start.text = "开始 "
                player.stop()
            }
        }

        //快进快退10s
        Flatbutton {

            Text {
                text: qsTr("后退")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {

                if (player.seekable) {
                    var pos = player.position - 10000
                    player.seek(pos)
                }
            }
        }

        Flatbutton {

            Text {
                text: qsTr("前进")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                if (player.seekable) {
                    var pos = player.position + 10000
                    player.seek(pos)
                }
            }
        }
        Flatbutton {
            Text {
                text: qsTr("LOVE")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                listModel.addMusic(musicPath)
            }
        }
        Flatbutton {
            id: listButton
            Text {
                text: qsTr("List")
                anchors.centerIn: parent
                color: colorfont
            }
            onClicked: {
                listMenu.visible = !listMenu.visible
//                listMenu.addListPage.listMenuModelChanged()
              //  listMenu.enabled = !listMenu.enabled
            }
        }
    }
}

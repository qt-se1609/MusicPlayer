import VPlayApps 1.0
import QtQuick 2.0
import server 1.0

//发送方页面 周敏
Page {
    id: serverPage

    //signal connectSucceeded
    Server {
        id: server
    }


    // property string filePath: filePath
    Column {
        //显示ip port
        id: ipAndPort
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 20
        anchors.leftMargin: 20
        AppText {
            text: "ip: " + server.ip
        }
        AppText {
            text: "port: " + server.port
        }
    }
    Row {
        id: openAndClose
        anchors.top: ipAndPort.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        //        AppButton{
        //            id: open
        //            text: qsTr("Open")
        //            onClicked: {
        //                console.debug("open...")
        //            }
        //        }
        //        AppButton{
        //            id: close
        //            text: qsTr("Close")
        //            enabled: false
        //            onClicked: {
        //                childNavigationStack.popAllExceptFirst()
        //                console.debug("close...")
        //            }
        //        }
    }
    AppText {
        //显示是否连接成功
        id: message
        text: "wait connect... "
        fontSize: 10
        color: "grey"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: openAndClose.bottom
    }
    Row {
        id: selectAndSend
        anchors.top: message.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        AppButton {
            //选择传输文件按钮
            id: selectFile
            text: qsTr("Select File")
            enabled: false
            onClicked: {
                console.debug("Select File...")
                childNavigationStack.push(musicList)
                console.log("file path", filePath)
                //                server.openFile(filePath)
            }
        }
        AppButton {
            //发送按钮
            id: sendFile
            text: qsTr("Send File")
            enabled: false
            onClicked: {
                server.sendHead()
                //console.debug("Send File...")
            }
        }
    }
    Connections {
        //处理server的连接成功信号
        target: server
        onConnectSucceeded: {
            message.text = "connected, please select send file"
            message.color = "blue"
            selectFile.enabled = true
            console.debug("Connections")
        }
    }
    Connections {
        //处理server的文件打开成功信号
        target: server
        onSelectSucceeded: {
            sendFile.enabled = true
            console.debug("selet file succeeded")
        }
    }

    // 打开选择文件的页
    property Component musicList: SelectFilePage {
        id: selectMusicListPage
        title: "select file"
    }
}

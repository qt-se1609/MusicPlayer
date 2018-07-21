import VPlayApps 1.0
import QtQuick 2.0
import QtQuick.Layouts 1.1
import client 1.0

//接收方页面 周敏

Page {
    id: serverPage
    title: "Connect"
    signal connectSucceeded

    width: parent.width
    Client{
        id: client
    }

    backgroundColor: Qt.rgba(0,0,0, 0.75) // page background is translucent, we can see other items beneath the page

    // connect form background
    Rectangle {
        id: serverForm
        anchors.centerIn: parent
        color: "white"
        width: content.width + dp(48)
        height: content.height + dp(16)
        radius: dp(4)
    }

    // connect form content
    GridLayout {
        id: content
        anchors.centerIn: serverForm
        columnSpacing: dp(20)
        rowSpacing: dp(10)
        columns: 2

        // headline
        AppText { //titel
            Layout.topMargin: dp(8)
            Layout.bottomMargin: dp(12)
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            text: "Connect"
        }
        // ip text
        AppText {
            text: qsTr("Ip:")
            font.pixelSize: sp(12)
        }

        AppTextField { //输入ip
            id: txtIp
            Layout.preferredWidth: dp(180)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
        }

        // Port text
        AppText {
            text: qsTr("Port")
            font.pixelSize: sp(12)
        }

        AppTextField {  //输入port
            id: txtPort
            Layout.preferredWidth: dp(180)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
        }

        Column {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.topMargin: dp(12)

            // buttons
            AppButton {
                text: qsTr("Connect")
                flat: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    serverPage.forceActiveFocus() // move focus away from text fields
                    //将输入的 ip 和 port 传入到client中，进行连接
                    client.getIpAndPort(txtIp.text, txtPort.text)
                    console.debug("connect in ...")
                }
            }

            AppText { //提示信息
                id: message
                text: qsTr("Must Server As Wall")
                font.pixelSize: sp(12)
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Connections{ //处理client里面的接受文件成功信号
            target: client
            onConnectSucceeded: {
                message.text = "receive succeeded"
            }
        }

    }
}

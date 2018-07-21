import VPlayApps 1.0
import QtQuick 2.0
import QtQuick.Window 2.2
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

//音量条 李楷
Slider {

    width: myPlay.width * 0.2
    height: 10
    value: 0.5

    anchors.verticalCenter: parent.verticalCenter

    style: SliderStyle {
        groove: Rectangle { //yinliang tiao
            implicitWidth: myPlay.width * 0.6
            implicitHeight: 7
            color: "#9D9D9D"
            radius: 10
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                radius: 10
                width: player.volume > 0 ? parent.width * player.volume : 0
                color: mainColor
            }
        }

        handle: Rectangle { // jindutiao dayuan
            anchors.centerIn: parent
            color: control.pressed ? mainColor : mainColor
            border.color: mainColor
            border.width: 0.2
            implicitWidth: 7.5 //dayuan
            implicitHeight: 7.5
            radius: 5
            Rectangle { //xiaoyuan
                width: 3
                height: 3
                radius: 2.5
                color: "white"
                anchors.centerIn: parent
            }
        }
    }
}

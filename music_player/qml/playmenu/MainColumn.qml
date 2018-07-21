import QtQuick 2.0
//import QtQuick.Window 2.2
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2


//播放条 李楷
Rectangle {
    color: "white"
    width: myPlay.width
    property int math: 20
    height: 16
    MouseArea{
        anchors.fill:parent
    }

    Row {
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        anchors.left: parent.left
        //调节播放速度
        Slider {
            id: playPos
            width: myPlay.width - math
            height: 10
            maximumValue: player.duration //播放条的结束点
            minimumValue: 0//播放条的开始点
            value: player.position
            anchors.verticalCenter: parent.verticalCenter
            stepSize: 1000
            style: SliderStyle {
                groove: Rectangle {
                    width: myPlay.width - math
                    height: 2
                    color: "#9D9D9D"
                    radius: 2
                    Rectangle {
                        id: slider
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        //进度条进展
                        //                        width: player.duration > 0 ? player.duration : 0
                        width: player.duration > 0 ? (parent.width) * player.position
                                                     / player.duration : 0
                        //播放条播放速度和歌曲的同步
                        color: mainColor
                    }
                }

                //进度条圆点跟踪
                handle: Rectangle {
                    //外圆
                    anchors.centerIn: parent
                    color: control.pressed ? "balck" : "white"
                    border.color: mainColor
                    border.width: 2
                    implicitWidth: 15
                    implicitHeight: 15
                    radius: 7.5
                    Rectangle {
                        //内圆
                        width: parent.width - 8
                        height: width
                        radius: width / 2
                        color: mainColor
                        anchors.centerIn: parent
                    }
                }
            }
            //设置鼠标可拖动进度条的播放位置
            MouseArea {
                property int po
                anchors.fill: parent
                onClicked: {
                    if (player.seekable)
                        po = player.duration * mouse.x / parent.width
                    player.seek(po)
                }
            }
        }
    }
}

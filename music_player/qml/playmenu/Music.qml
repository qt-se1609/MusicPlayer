import QtQuick 2.0
import QtQuick.Window 2.2
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import VPlayApps 1.0

//播放功能实现块 李楷
Item {
    id: myPlay
    visible: true
    width: parent.width
    height: colum.height

    MediaPlayer {
        //获取音频链接
        id: player
        source: musicPath
        autoPlay: true
        volume: voice.value
    }

    VideoOutput {
        //获取视频
        anchors.fill: parent
        source: player
    }

    //主窗体区域，设置界面
    //start.end
    Column {
        id: colum
        anchors.bottom: parent.bottom

        Rectangle {
            id: screen
            width: myPlay.width
            color: "blue"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (player.seekable)
                        p.clicked()
                }
            }
        }

        //控制区域
        //s
        NewBorder {
            id: bottom
            width: myPlay.width
        }

        //end
        Rectangle {
            id: sound
            border.width: 0
            height: control.height
            width: myPlay.width

            Row {
                spacing: 10
                anchors.left: parent.left
                anchors.leftMargin: 10

                Text {
                    text: qsTr("<))")
                    color: "black"
                }

                Sound {
                    id: voice
                }

                //                时间格式化
                function currentTime(time) {
                    var sec = Math.floor(time / 1000) //求出歌曲时间总的秒数
                    var hours = Math.floor(sec / 3600)
                    var minutes = Math.floor(
                                (sec - hours * 3600) / 60) //求出歌曲时间的分钟数
                    var seconds = sec - hours * 3600 - minutes * 60 //求出歌曲时间的剩余秒数
                    var mm = 0, ss = 0

                    if (minutes.toString().length < 2)
                        mm = 0 + minutes.toString()
                    else
                        mm = minutes.toString()
                    if (minutes.toString().length < 2)
                        ss = 0 + seconds.toString()
                    else
                        ss = seconds.toString()

                    return mm + ":" + ss
                }

                function playernext() {
                    if (currentTime(player.position) === currentTime(player.duration)) {
                         if (listModel.noEnd(listName ,currentIndex))
                            currentIndex++
                         else
                             currentIndex = 0

                        musicName = listModel.getMusicName(listName, currentIndex)
                        player.source = listModel.getMusicPath(listName ,currentIndex)
                    }
                    return "";
                }
                Text {
                    //显示音频播放的时间和总共时长
                    id: timetext
                    anchors.verticalCenter: parent.verticalCenter
                    text: parent.currentTime(player.position) + "/"
                          + parent.currentTime(player.duration) + parent.playernext()
                    color: "black"
                }
            }
        }
        //s
        //播放进度
        MainColumn {
            id: control
        }

        //end
    }
    //end
}

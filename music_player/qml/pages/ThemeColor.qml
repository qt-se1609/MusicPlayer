import VPlayApps 1.0
import QtQuick 2.1

//主题页框 周敏
Rectangle{
    id: rec
    property string themeColor
    property var margin: 100

    property int w: changeColor.width
    property int h: rSize

    width: changeColor.width
    height: rSize
    Rectangle{
        id: themeRec
        width: changeColor.width - margin
        height: rSize - 20
        radius: 30
        anchors.centerIn: parent
        color: themeColor
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Theme.colors.tintColor = themeColor
                mainColor = themeColor

            }
            onEntered: {
                //点击时变大
                themeRec.width = w;
                themeRec.height = h - 10;
            }
            onExited: {
                //点击后回复大小
                themeRec.width = w - margin
                themeRec.height = h - 20
            }
        }
    }
}


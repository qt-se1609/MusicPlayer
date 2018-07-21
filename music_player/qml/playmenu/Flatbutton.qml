import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Window 2.2
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

//设置按钮基本信息 提供背景和边框 李楷
Rectangle {
    id: bkgd
    height: 30
    width: 60
    color: mainColor
    radius: 10
    property bool hovered: true
    border.color: "white" //边框颜色
    border.width: hovered ? 5 : 0

    signal clicked

//    Image { //设置按钮背景图片
//        width: parent.width - 8
//        height: parent.height - 8
//        anchors.centerIn: parent
//        source: "../../assets/music2.jpg"
//    }
    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true //设置鼠标悬停事件
        onEntered: {
            bkgd.hovered = false //鼠标悬不显示边框颜色，边框为主题颜色
        }
        onExited: {
            bkgd.hovered = true //没有鼠标时，显示颜色
        }
        onClicked: {
            bkgd.hovered = true //点击时，颜色出现
            bkgd.clicked()
        }
    }
}

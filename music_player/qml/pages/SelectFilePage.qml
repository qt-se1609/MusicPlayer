 import VPlayApps 1.0
import QtQuick 2.0

//选择传输文件页 周敏、田益兰
Page {
    property string filePath
    AppListView {//由系统导入的mp3文件
        id: listView
        anchors.bottom: selectBottom.bottom
        width: parent.width
        model: myModel.list
        delegate: SimpleRow {
            text: modelData
            onSelected: {//选择文件
                selectBottom.text = "select " + text
                selectBottom.enabled = true
//                filePath = text
                //                console.log(text)
//                console.log(myModel.getPath(text))
                musicName = text
                musicPath = myModel.getMusicPath(index)
            }
        }
    }

    AppButton{ //确定选择传输的文件
        id: selectBottom
        text: "plaese selete file"
        width: 50
        enabled: false
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            server.openFile(musicPath)
            childNavigationStack.pop(musicList)
            popped()
        }
    }
}

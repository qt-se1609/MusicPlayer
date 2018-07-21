import QtQuick 2.0
import VPlayApps 1.0

//歌单列表清单 田益兰
Page {
    id: perferPage
    title: "perfer"
    AppListView {
        //自己喜欢的音乐到我的音乐列表
        id: listView
        width: parent.width
        model: listModel.perferMusicList
        delegate: SimpleRow {
            text: modelData
            onSelected: {
                listName = "perfer"
                currentIndex = index
                //                console.log(text)
                musicName = listModel.getMusicName(listName, index)
                musicPath = listModel.getMusicPath(listName, index)
                //                console.log(musicPath)
                selectBottom.enabled = true

            }
        }
    }

    AppButton {
        //删除本地列表中的音乐
        id: selectBottom
        text: "删除"
        width: 50
        enabled: false
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            listModel.deleteMusic(musicPath)
            childNavigationStack.pop(perferList)
            //            console.log(listModel.deleteMuaic(musicPath))
        }
    }
}

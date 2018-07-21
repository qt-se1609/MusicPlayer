import VPlayApps 1.0
import QtQuick 2.1
import "../pages"

//歌单列表 田益兰
ListPage {
    id: page

    AppListView {
        //由系统导入的mp3文件
        id: listView
        width: parent.width
        model: listModel.rootList
        delegate: SimpleRow {
            //列表显示系统中mp3文件
            text: modelData
            onSelected: {
                listName = ""
                currentIndex = index
                musicName = text
                musicPath = listModel.getMusicPath(listName ,currentIndex)
                startButton = "暂停"
            }
        }
    }
}

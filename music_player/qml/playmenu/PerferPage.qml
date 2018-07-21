import VPlayApps 1.0
import QtQuick 2.2

//我的歌单 田益兰
ListPage {
    width: parent.width
    AppListView {
        width: parent.width

        model: ListModel {
            //歌单
            ListElement {
                name: "Perfer"
            }
        }

        delegate: SimpleRow {
            text: name
            onSelected: {
                //console.log(name)
                if (text == "Perfer")
                    globalNavStack.popAllExceptFirstAndPush(perferList)
            }
        }
    }

    property Component perferList: PerferList {
    }
}

import VPlayApps 1.0
import QtQuick 2.1

//传输音乐页面 周敏
ListPage {
        title: "分享音乐"

        model: [
            { text: "发送"},
            { text: "接收"},
        ]

        onItemSelected: {
            if(index == 0)
                childNavigationStack.popAllExceptFirstAndPush(serverPage)
            if(index == 1)
                childNavigationStack.popAllExceptFirstAndPush(clientPage)
        }


    property Component serverPage: ServerPage {
        id: serverPage
        title: "发送"
    }

    property Component clientPage: ClientPage {
        id: clientPage
        title: "接收"
    }
}

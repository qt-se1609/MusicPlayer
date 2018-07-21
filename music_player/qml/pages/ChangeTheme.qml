import VPlayApps 1.0
import QtQuick 2.1
import "../"

//主题页 周敏
ListPage{
    id: changeColor
    property var rSize: 100

    Column{
        ThemeColor{
            id: t0
            themeColor: "#475057"
        }
        ThemeColor{
            id: t1
            themeColor: "#9D0001"
        }
        ThemeColor{
            id: t2
            themeColor: "#003D79"
        }
        ThemeColor{
            id: t3
            themeColor: "#8080C0"
        }
        ThemeColor{
            id: t4
            themeColor: "#5CADAD"
        }
        ThemeColor{
            id: t5
            themeColor: "#A5A552"
        }
    }

}

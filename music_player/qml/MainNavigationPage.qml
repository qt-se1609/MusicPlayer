import VPlayApps 1.0
import QtQuick 2.0
import "pages"
import "playmenu"

//功能导航页
Page {
    property alias childNavigationStack: globalNavStack
    property alias navigation: navigation

    useSafeArea: false // full screen

    NavigationStack {
        //导航页面栈
        id: globalNavStack

        // Wrapper page
        Page {
            navigationBarHidden: Theme.isAndroid
            useSafeArea: false // full screen

            title: navigation.currentNavigationItem ? navigation.currentNavigationItem.title : ""

            Navigation {
                id: navigation

                navigationMode: navigationModeDrawer //使用导航页模式

                NavigationItem {
                    //全部音乐列表
                    title: musicName
                    icon: IconType.clocko
                    onSelected: {
                        if (childNavigationStack.splitViewActive)
                            childNavigationStack.popAllExceptFirstAndPush(
                                        lyrics)
                    }
                    MainPage {
                    }
                }

                NavigationItem {
                    //歌单列表
                    id: myPalyList
                    title: qsTr("我的歌单")
                    icon: IconType.group
                    MusicListPage {
                    }
                }

                NavigationItem {
                    //最喜欢的音乐播放列表
                    id: localpalyList
                    title: qsTr("喜爱的歌曲")
                    icon: IconType.group
                    PerferPage {
                    }
                }

                NavigationItem {
                    //传输音乐列表
                    id: csItem
                    title: qsTr("分享音乐")
                    icon: IconType.group
                    CSPage {
                    }
                }

                NavigationItem {
                    //传输音乐列表
                    id: theme
                    title: qsTr("更换主题")
                    icon: IconType.group
                    onSelected: {
                        if (childNavigationStack.splitViewActive)
                            childNavigationStack.popAllExceptFirstAndPush(
                                        lyrics)
                    }
                    ChangeTheme {
                    }
                }
            }
        }
        property Component lyrics: Lyrics {
            id: lyrics
            title: musicName
        }
    }
}

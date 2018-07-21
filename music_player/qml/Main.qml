import VPlayApps 1.0
import QtQuick 2.0

App {
    id: app

    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"

    property string mainColor: "#475057" //主题颜色
    property string colorfont: "white"

    onInitTheme: {
        Theme.colors.tintColor = mainColor
        Theme.navigationBar.itemColor = "white"
    }

    Fram {
    }

    //  MainPage { //导航页

    //  }
}

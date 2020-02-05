import QtQuick 2.12
import QtQuick.Controls 2.5
import QtWebSockets 1.0

ApplicationWindow {
    id:appwin
    visible: true
    width:  screen.width
    height: screen.height
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        interactive:false
        anchors.fill: parent
        currentIndex: footbar.currentIndex

        Me{
            id:me
        }

//        MyMap {
//            id:mymap
//        }
//        MessageList{
//            id:msglist
//        }

//        FollowList{
//            id:follow
//        }


    }

    footer: TabBar {
        id: footbar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("地图")
            icon.source: "./images/ditu.png"
            icon.color: 'red'
            font.pointSize: 14
            font.family: "DroidSansFallback"
             display: Button.TextBesideIcon
        }

        TabButton {
            text: qsTr("消息")
            icon.source: "./images/message.png"
            icon.color: 'red'
            icon.height: 24
            icon.width: 24
            font.pointSize: 14
            font.family: "DroidSansFallback"
            display: Button.TextBesideIcon
        }

        TabButton {
            text: qsTr("关注")
            icon.source: "./images/guanzhu.png"
            icon.color: 'red'
            font.pointSize: 14
            font.family: "DroidSansFallback"
            display: Button.TextBesideIcon
        }

        TabButton {
            text: qsTr("我的")
            icon.source: "./images/wode.png"
            icon.color: 'red'
            font.pointSize: 14
            font.family: "DroidSansFallback"
            display: Button.TextBesideIcon
        }
    }
}

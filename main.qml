import QtQuick 2.12
import QtQuick.Controls 2.5
import QtWebSockets 1.0

ApplicationWindow {
    id:appwin
    visible: true
    width: 500
    height: 790
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        interactive:false
        anchors.fill: parent
        currentIndex: tabBar.currentIndex



        MyMap {
            id:mymap
        }

        MessageList{
            id:msglist
        }
        FollowList{
            id:follow
        }

        Me{
            id:me
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("地图")
            icon.source: "./images/ditu.png"
            icon.color: 'red'
            display: Button.TextUnderIcon
        }

        TabButton {
            text: qsTr("消息")
            icon.source: "./images/message.png"
            icon.color: 'red'
            display: Button.TextUnderIcon
        }

        TabButton {
            text: qsTr("关注")
            icon.source: "./images/guanzhu.png"
            icon.color: 'red'
            display: Button.TextUnderIcon
        }

        TabButton {
            text: qsTr("我的")
            icon.source: "./images/wode.png"
            icon.color: 'red'
            display: Button.TextUnderIcon
        }
    }
}

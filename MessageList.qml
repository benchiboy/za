
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "./component"

Page {
    id: chatsView
    title: "FriendList"

    property int headPrtraitSize: 90

    FontLoader { id: localFont; source: "images/NotoSansSC-Regular.ttf"
    onStatusChanged:{
        console.log("-------------------------->")
    }
    }


    TopBar{
            id:tabbar
            height: 40
            z:1000
            Rectangle{
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: "red"
                width:msg_count.contentWidth+5
                height: msg_count.contentHeight+5
                radius: 10
//                Text {
//                    id: msg_count
//                    color: "white"
//                    text: qsTr("20")
//                    anchors.centerIn: parent
//                }


                Text {
                    color: "red"
                    id: name
                    font.family: localFont.name; font.pixelSize: 16
                    text: qsTr("忍也忍")
                }

            }

            SampleIcon {
                iconSource:"images/plus.png"
                anchors.right: parent.right
                anchors.rightMargin: 10
                id: iconButton1
                iconSize: Qt.size( tabbar.height - 2,  tabbar.height - 2)
                onClicked: {

                }
            }
      }

      ///////////////////////////////////
      StackView {
          id: stackView
          anchors.fill: parent
          focus: true
          Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
               stackView.pop()
               event.accepted = true;
          }
          initialItem: Item {
              width: chatsView.width
              height: chatsView.height
          }
     }

    ListView {
        anchors.top: tabbar.bottom
        id: listView
        width: chatsView.width
        height: chatsView.height
        model: chatItemsModel
        highlightMoveDuration: 1000
      //  highlightRangeMode: ListView.ApplyRange
        // 控制滚动速度
        maximumFlickVelocity: 5000
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
        }
        move: Transition {
            NumberAnimation { properties: "x,y"; duration: 800; easing.type: Easing.OutBack }
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
        }
        states: [
            State {
                name: "ShowBar"
                when: listView.movingVertically
                PropertyChanges { target: verticalScrollBar; opacity: 1 }
            },
            State {
                name: "HideBar"
                when: !listView.movingVertically
                PropertyChanges { target: verticalScrollBar; opacity: 0 }
            }
        ]

        transitions: [
            Transition {
                from: "ShowBar"
                to: "HideBar"
                NumberAnimation { properties: "opacity"; duration: 400 }
            },
            Transition {
                from: "HideBar"
                to: "ShowBar"
                NumberAnimation { properties: "opacity"; duration: 400 }
            }
        ]

//        ScrollBar {
//            id: verticalScrollBar
//            //width: 10 * Screen.devicePixelRatio
//            height: listView.height - width
//            anchors.right: listView.right
//            orientation: Qt.Vertical
//            position: listView.visibleArea.yPosition
//            pageSize: listView.visibleArea.heightRatio
//        }


        delegate: Rectangle {
            id: chatItem
            property int chatItemHeight: chatItemRowLayout.height

            width: chatsView.width
            height: chatItem.chatItemHeight+5
            color: "transparent"
            border.width: 1


            border.color: "#ddd"
            state: "UnSelected"
            states: [
                State {
                    name: "Selected"
                    PropertyChanges { target:chatItem; color: "#ccc" }
                },
                State {
                    name: "UnSelected"
                    PropertyChanges { target:chatItem; color: "transparent" }
                }
            ]

            transitions: [
                Transition {
                    from: "Selected"
                    to: "UnSelected"
                    NumberAnimation { properties: "color"; duration: 400 }
                },
                Transition {
                    from: "UnSelected"
                    to: "Selected"
                    NumberAnimation { properties: "color"; duration: 400 }
                }
            ]

            Row {
                id: chatItemRowLayout
                width: parent.width
                height: 50

                Image {
                    id:user_logo
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.width: 32
                    sourceSize.height: 32
                    source: "./images/wo.png"
                    fillMode: Image.PreserveAspectFit
                }


                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: user_logo.right
                    anchors.leftMargin: 10

                    Row {
                        spacing: chatsView.width-160
                        Text {
                            id: user_name
                            text: qsTr(name)
                            font.pointSize: 18
                           // font.family: "Times"

                            font.family: localFont.name; font.pixelSize: 16

                        }


                        Text {
                            id: chat_time
                            text: qsTr(chatTime)
                            font.pointSize: 16
                            color: "grey"
                            font.family: "Droid Sans Fallback"


                        }
                    }

                    Row {
                          Text {
                              width: chatsView.width-80
                              id: chat_context
                              text: qsTr(chatContext)
                              elide: Text.ElideRight
                              color: "grey"
                                font.family: localFont.name; font.pixelSize: 16
                             // font.pointSize: 16
                             // font.family: "Droid Sans Fallback"
                          }
                    }
                }

            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: {
                    listView.visible=false
                    tabbar.visible=false
                    footbar.visible=false
                    stackView.push("./Message.qml")

                }
            }
        }


        ListModel {
            id: chatItemsModel
            Component.onCompleted: {
                for(var i=0; i<5; i++) {
                    chatItemsModel
                    .append(
                         {
                             "chatTime": "12:12:12",
                             "name":"忍野忍",
                             "chatisBool": false,
                             "chatContext":"是开发借款时间付款时间222222222开始放假SDK😞"
                         });
                }
            }
        }
    }




}


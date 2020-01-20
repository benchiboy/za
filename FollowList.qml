import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "./component"

Page {
    id: followView
    title: "FriendList"


    TopBar{
          id:topbar
          height: 40
          z:1000
          SampleIcon {
              iconSource:"images/plus.png"
              anchors.right: parent.right
              anchors.rightMargin: 10
              id: iconButton1
              iconSize: Qt.size( topbar.height - 2,  topbar.height - 2)
              onClicked: {

              }
          }

          RowLayout{
             id:tabtype
             height: 35
             width: followView.width

             Rectangle{
                  Layout.alignment: Qt.AlignHCenter
                  width: me_follow.contentWidth+10
                  height: parent.height-5
                  color: "grey"
                  radius: 5
                  Label{
                      id:me_follow
                      anchors.centerIn: parent
                      text: "我关注的"
                      color: "red"
                  }
             }

             Rectangle{
                  Layout.alignment: Qt.AlignHCenter
                 width: follow_me.contentWidth+10
                 height: parent.height-5
                 color: "lightgrey"
                 radius: 5
                 Label{
                      id:follow_me
                      anchors.centerIn: parent
                      text: "关注我的"
                      color: "black"
                  }
             }
          }
    }





    ListView {
        anchors.top: topbar.bottom
        id: listView
        width: followView.width
        height: followView.height
        model: chatItemsModel
        highlightMoveDuration: 1000
        //highlightRangeMode: ListView.ApplyRange
        // 控制滚动速度
        maximumFlickVelocity: 5000
        delegate: Rectangle {
            id: chatItem
            width: followView.width
            height: chatItemRowLayout.height
            color: "transparent"
            border.width: 1
            border.color: "#ddd"
            RowLayout {
                id: chatItemRowLayout
                width: parent.width
                height: 50
                Rectangle{
                    width: 40
                    height: 40
                    Layout.leftMargin: 10
                    radius: 5
                    color: "#ddd"
                    Image {
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        sourceSize.width: 32
                        sourceSize.height: 32
                        source: "./images/wo.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle{
                    width: 40
                    height: 40
                    Layout.leftMargin: 20
                    Layout.fillWidth: true
                    Label{
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.leftMargin: 20
                        font.pixelSize: 16
                         font.family: "SimSun"
                        id:label_name
                        text: name

                    }
                }
            }
        }

        ListModel {
            id: chatItemsModel
            Component.onCompleted: {
                for(var i=0; i<110; i++) {
                    chatItemsModel
                    .append(
                         {
                             "name":"忍野忍",
                         });
                }
            }
        }
    }
     Rectangle {
            id: bar
            height: parent.height-41
            width: screen.pixelDensity * 15 // 2mn
            anchors.top: parent.top
            anchors.topMargin: 41
            anchors.right: parent.right
            anchors.rightMargin: 10
            color: Qt.rgba(0.5, 0.5, 0.5, 0.5)
            opacity: 0.5
            ColumnLayout {
                anchors.fill: parent
                Repeater {
                    id: repeater
                    model: ["↑", "☆","a", "b", "c", "d", "e", "f"
                        , "g", "h", "i", "j", "k", "l", "m", "n",
                        "o", "p", "q", "r", "s", "t", "u", "v", "w",
                        "x", "y", "z"]
                        Text {
                            color: "red"
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: repeater.model[index]
                            font.pointSize:16
                        }
                }
            }
      }

}

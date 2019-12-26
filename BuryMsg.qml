import QtQuick 2.0
import QtWebView 1.1
import QtQuick.Controls 2.5

Item {
    id:msgPopup
   Rectangle {
      radius: 10
      color: "lightgrey"
      z:1000

      anchors.fill: parent
      Column{
          spacing: 10
          anchors.horizontalCenter: parent.horizontalCenter
          TextArea{
             id:userInput
              anchors.horizontalCenter: parent.horizontalCenter
              width: msgPopup.width*0.9
              height: msgPopup.height*0.7
              font.pixelSize: 18
              placeholderText: "输入消息"
              background:Rectangle{
              implicitWidth: msgPopup.width*0.9
              implicitHeight: msgPopup.height*0.7
              radius: 10
              color:"white"
              border.color: "blue"
            }
          }
          Row{
              anchors.horizontalCenter: parent.horizontalCenter
              spacing: 40
              Button{
               text:"确定"
               width: 60
               height: 40
                background: Rectangle{
                   color: "green"
                   opacity: 0.7
                   radius: 10
               }

                onClicked: {
                    msgPopup.visible=false

                }
              }
              Button{
               text:"取消"
               width: 60
               height: 40
                background: Rectangle{
                   color: "green"
                   opacity: 0.7
                   radius: 10
               }
               onClicked: {
                   msgPopup.visible=false

               }
              }
          }
      }
  }
}


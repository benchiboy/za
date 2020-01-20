import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "./component"
import QtQuick.Dialogs 1.3

Page {

    Rectangle {
        color: "white"
        anchors.fill: parent
    }
    property bool  islogin: false


    ColumnLayout{
        spacing: 10
        width: parent.width
      Rectangle {
         color: "#ddd"
         radius: 4
         Layout.preferredWidth: parent.width
         Layout.preferredHeight: 100

        Image {
            id:userHeadImage
            source: "../images/wo.png"
            height: 50
            width: 50
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 40
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
        }

        Column{
            anchors.fill: parent
            Text {
                anchors.verticalCenter: parent.verticalCenter
                id: phone
                visible: islogin ?1 :0
                text: qsTr("currUser")
                font.pixelSize: 18
                font.bold: true
                anchors.left: parent.left
                anchors.leftMargin: 100
            }

            Text {
                id: login
                anchors.verticalCenter: parent.verticalCenter
                visible: !islogin ? 1 :0
                text: qsTr("登录/注册")
                font.pixelSize: 17
                color: "blue"
                font.underline: true
                anchors.left: parent.left
                anchors.leftMargin: 100
                MouseArea{
                    anchors.fill: parent
                    onClicked: {


                    }
                }
            }
        }


     }



      Rectangle {
         color: helpMouse.pressed ? "grey" : "black"
         radius: 4
         Layout.preferredWidth: parent.width
         Layout.preferredHeight: 50
         Image {
            source: "../images/help.png"
            height: 20
            width: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 60
        }

         Text {
            id:help
            color: 'white'
            text: qsTr("帮助说明")
            font.pixelSize: 18
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 150
        }

        Image {
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "../images/navigation_next_item.png"
            height: 30
            width: 30
        }

        MouseArea {
            id: helpMouse
            anchors.fill: parent
            onClicked: {
                helpDialog.createContact()
            }

        }
     }


      TextArea{
          Layout.preferredWidth: parent.width
          Layout.preferredHeight: 50
          id:userInput
          focus:true
          height: 50
          width: 200
          font.pixelSize: 18
          placeholderText: "输入消息"


          MouseArea{

              onClicked: {
                    console.log("==========>")
              }

          }
      }




      Rectangle {
         color: quitMouse.pressed ? "grey" : "black"
         radius: 4
         Layout.preferredWidth: parent.width
         Layout.preferredHeight: 50
         Image {
            source: "../images/tuichu.png"
            height: 20
            width: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 60
        }

         Text {
            id:quit
            color: 'white'
            text: qsTr("退出系统")
            font.pixelSize: 18
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 150
        }

        Image {
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "../images/navigation_next_item.png"
            height: 30
            width: 30
        }

        MouseArea {
            id: quitMouse
            anchors.fill: parent
            onClicked: {
                Qt.quit()
            }
        }
     }






    }


    Component.onCompleted: {

    }

}


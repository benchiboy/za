import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.3
import "comm.js" as Logic
Page {

    property  int  getIndex: 0
    property  string  userName:""
    property  string  userPwd:""
    property  string  userImage:""

    TopArea{
       id:toparea
    }

    MsgBox{
        id:toast
        anchors.centerIn: parent
    }

    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: toparea.bottom
        anchors.topMargin: 20
        spacing: 25

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                width: 60
                height: 60
                border.color: "grey"
                radius: 50
                Image {
                   anchors.fill: parent
                   anchors.margins: 10
                   id: name
                   source: userImage
               }
            }
        }

        Row{
           anchors.horizontalCenter: parent.horizontalCenter

           Column{
               Text {
                   id: cbItemsTip
                   font.bold: false
                   font.pointSize: 16
                   text: qsTr("设置一个问题,用于找回密码！")
               }
               ComboBox {
                   id:resetPwdProblem
                   currentIndex: 0
                   model: ListModel {
                       id: cbItems
                       ListElement { text: "你的手机号码"; }
                       ListElement { text: "你的小学名称";  }
                       ListElement { text: "你的生日";  }
                   }
                   implicitWidth: 250
                   implicitHeight: 50
                   background: Rectangle{
                       radius: 10
                       color: resetPwdProblem.enabled ? "transparent" : "#353637"
                       border.color: resetPwdProblem.enabled ? "#21be2b" : "transparent"
                   }
                   onCurrentIndexChanged: {
                       getIndex=currentIndex
                   }
               }
           }
        }


        Row{
           anchors.horizontalCenter: parent.horizontalCenter
           Column{
               Text {
                   id: resetPwdAnswerTip
                   font.bold: false
                   font.pointSize: 16
                   text: qsTr("设置问题的答案!")
               }
               TextField {
                id: resetPwdAnswer
                placeholderText: qsTr("问题答案")
                background: Rectangle {
                    implicitWidth: 250
                    implicitHeight: 40
                    radius: 10
                    color: resetPwdAnswer.enabled ? "transparent" : "#353637"
                    border.color: resetPwdAnswer.enabled ? "#21be2b" : "transparent"
                }
            }

           }
        }

      }



    Row{
        anchors.bottom:  parent.bottom
        anchors.bottomMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        Button {
               id: button
               anchors.horizontalCenter: parent.horizontalCenter
               anchors.verticalCenter: parent.verticalCenter
               Text {
                   anchors.centerIn: parent
                   id: next
                   color: "white"
                    font.pointSize: 16
                   text: qsTr("确定")
               }
               background: Rectangle {
                   implicitWidth: 250
                   implicitHeight: 40
                   color:  "green"
                   border.color: button.down ? "red" : "#f6f6f6"
                   border.width: 1
                   radius: 4
               }
               onClicked: {
                   if (resetPwdAnswer.text==""){
                        toast.showMsgBox("问题答案不能为空")
                        return
                   }
                   console.log("=====>",userPwd)
                   var ret=Logic.signup(userName,userPwd,cbItems.get(getIndex).text,resetPwdAnswer.text,userImage)
                   if (ret.err_code==="0000"){
                      stackView.push("SignUpResult.qml",{userImage:"",userName:userName})
                   }else{
                       toast.showMsgBox("问题答案不能为空")
                   }
               }
           }
     }
}

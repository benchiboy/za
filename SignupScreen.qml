import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.3
import "comm.js" as Logic

Page {
    width: parent.width
    height:parent.height

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
            Column{
                Rectangle{
                   width: 60
                   height: 60
                   border.color: "grey"
                   radius: 50
                   anchors.horizontalCenter: parent.horizontalCenter
                   Image {
                       anchors.fill: parent
                       anchors.margins: 10
                       id: userHeadImage
                       source: "image/user.png"
                       MouseArea{
                         anchors.fill: parent
                         onClicked: {
                            headImageSel.open()
                         }
                       }
                   }
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    id: userTip
                    text: qsTr("点击选择头像")
                    font.pointSize: 16
                }
            }
        }

        Row{
           anchors.horizontalCenter: parent.horizontalCenter
            TextField {
                id: nickName
                placeholderText: qsTr("起个昵称:如陈小明")
                maximumLength: 15
                background: Rectangle {
                    implicitWidth: 250
                    implicitHeight: 40
                    radius: 10
                    color: nickName.enabled ? "transparent" : "#353637"
                    border.color: nickName.enabled ? "#21be2b" : "transparent"
                }
            }
        }

        Row{
           anchors.horizontalCenter: parent.horizontalCenter
            TextField {
                id: signupPwd
                placeholderText: qsTr("设置你的密码")
                maximumLength: 10
                echoMode: TextInput.Password
                background: Rectangle {
                    implicitWidth: 250
                    implicitHeight: 40
                    radius: 10
                    color: signupPwd.enabled ? "transparent" : "#353637"
                    border.color: signupPwd.enabled ? "#21be2b" : "transparent"
                }
            }
        }

        Row{
           anchors.horizontalCenter: parent.horizontalCenter
            TextField {
                id: signupPwdok
                placeholderText: qsTr("确认你的密码")
                maximumLength: 10
                echoMode: TextInput.Password
                background: Rectangle {
                    implicitWidth: 250
                    implicitHeight: 40
                    radius: 10
                    color: signupPwdok.enabled ? "transparent" : "#353637"
                    border.color: signupPwdok.enabled ? "#21be2b" : "transparent"
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
                   text: qsTr("下一步")
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

                   if (nickName.text===""){
                      toast.showMsgBox("登录账号不能为空")
                      return
                   }
                   if (signupPwd.text===""){
                      toast.showMsgBox("登录密码不能为空")
                      return
                   }

                   if (signupPwdok.text===""){
                      toast.showMsgBox("登录密码不能为空")
                      return
                   }

                   var ret=Logic.checkUser(nickName.text)
                   if (ret.err_code==="3000"){
                       stackView.push("SignUpForm.qml",{userImage:"",userName:nickName.text,userPwd:signupPwdok.text})
                   }else{
                       toast.showMsgBox(nickName.text+"此账户已经存在")
                   }
               }
           }
     }

}

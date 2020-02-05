import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.3
import "comm.js" as Logic
Page {

    property  int     getIndex: 0
    property  string  problemAnswer: ""
    property  string  problem: ""


    TopArea{
       id:toparea
    }


    MsgBox{
        id:toast
        anchors.centerIn: parent
    }


     Column{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
        spacing: 25
            Row{
               anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                    id: nickName
                    placeholderText: qsTr("输入自己登录账号")
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
               Button {
                       id: button
                       Text {
                           anchors.centerIn: parent
                           id: next
                           color: "white"
                           font.pointSize: 16
                           text: qsTr("找回预留问题")
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
                          if (nickName.text==""){
                              toast.showMsgBox("登录账号不能为空")
                             return
                          }

                          var ret=Logic.checkUser(nickName.text)
                          if (ret.err_code==="3000"){
                              toast.showMsgBox("不存在此账户")
                              return
                          }
                          problem=ret.pass_problem
                          console.log("problem======>",problem)



                          /////////
                          resetPwdProblem.visible=true
                          resetPwdAnswer.visible=true
                          resetNextButton.visible=true
                       }
                   }
            }
            Row{
               anchors.horizontalCenter: parent.horizontalCenter
               ComboBox {
                   id:resetPwdProblem
                   visible: false
                   currentIndex: 0
                   model: ListModel {
                       id: cbItems
                       ListElement { text: ""; }
                       ListElement { text: "你的手机号码"; }
                       ListElement { text: "你的小学名称";  }
                       ListElement { text: "你的生日";  }
                   }
                   implicitWidth: 250
                   implicitHeight: 40
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
            Row{
               anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                    id: resetPwdAnswer
                    visible: false
                    placeholderText: qsTr("预留的答案")
                    background: Rectangle {
                        implicitWidth: 250
                        implicitHeight: 50
                        radius: 10
                        color: resetPwdAnswer.enabled ? "transparent" : "#353637"
                        border.color: resetPwdAnswer.enabled ? "#21be2b" : "transparent"
                    }
                }
            }
            Row{
               anchors.top: parent.top
               anchors.topMargin: 400
               anchors.horizontalCenter: parent.horizontalCenter
               Button {
                       id: resetNextButton
                        visible: false
                       anchors.horizontalCenter: parent.horizontalCenter
                       anchors.verticalCenter: parent.verticalCenter
                       Text {
                           anchors.centerIn: parent
                           id: next1
                           color: "white"
                           font.pointSize: 16
                           text: qsTr("下一步")
                       }
                       background: Rectangle {
                           implicitWidth: 250
                           implicitHeight: 40
                           color:  "green"
                           border.color: resetNextButton.down ? "red" : "#f6f6f6"
                           border.width: 1
                           radius: 4
                       }
                       onClicked: {

                          if (nickName.text==""){
                             toast.showMsgBox("登录账号不能为空")
                              return
                          }
                          if (resetPwdAnswer.text==""){
                              toast.showMsgBox("预留的答案不能为空")
                              return
                          }

                          if (resetPwdProblem.textAt(resetPwdProblem.currentIndex)!==problem){
                              toast.showMsgBox("预留的问题不对")
                              return
                          }

                         var ret=Logic.verifyAnswer(nickName.text,problem,resetPwdAnswer.text)
                         if (ret.err_code!=="0000"){
                             toast.showMsgBox("预留的答案不对")
                            return
                         }
                         stackView.push("ResetpwdForm.qml",{userName:nickName.text,problem:problem,problemAnswer:resetPwdAnswer.text})

                       }
                   }
             }
          }
        }

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtMultimedia 5.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import "./component"

Item {
    id:messageBox
    property string playFile: "9999999999"
    property bool isLeft:false

    TopBar{
          id:topbar
          height: 40
          SampleIcon {
              iconSource:"images/navigation_previous_item.png"
              anchors.left:  parent.left
              anchors.leftMargin:  10
              id: backButton
              iconSize: Qt.size( topbar.height - 2,  topbar.height - 2)
              onClicked: {
                  tabBar.visible=true
                  listView.visible=true
                  stackView.pop()
              }
          }

    }
    ScrollView{
        background: Rectangle{
        }
        anchors.top: parent.top
        anchors.topMargin: 42
        clip:true
        id:scroll
        width: parent.width
        property ScrollBar hScrollBar: ScrollBar.horizontal
        property ScrollBar vScrollBar: ScrollBar.vertical
        height: parent.height*0.80
        Column{
            spacing: 10
            id:msgText
        }
    }

   Text {
       id: textExample
       color: "red"
       visible: false
       font.pixelSize: 16
       clip: true
       wrapMode: Text.WrapAnywhere
       text: "hello"
    }

    function sendMsg(sendMsg){
        scroll.vScrollBar.position=1
        if (sendMsg===""){
            return
        }
        textExample.text=sendMsg
        var textH=textExample.contentHeight+10
        var textW=textExample.contentWidth+10
        console.log("GD====>",textH)
        console.log("KD====>",textW)
        var obj = itemCompont.createObject(msgText, {msgText:sendMsg,gd:textH,kd:textW,userName:"jieke"})
        if (isLeft){
             obj.x=scroll.width-obj.width-10
             isLeft=false
             obj.isMe=true
        }else{
            obj.x=10
            isLeft=true
            obj.isMe=false
        }
    }


    Rectangle{
        id: mainRect
        height: parent.height*0.20
        width: parent.width
        color: "lightgrey"
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 0
        Column{
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 15
            Row{
                anchors.left: parent.left
                anchors.leftMargin: 20
                id:tool_button
                spacing: 30
                Image {
                    id: recordVoice
                    source: "./images/luyin.png"
                    width: 28
                    height: 28
                }
                Image {
                    id: pics
                    source: "./images/tupian.png"
                    width: 30
                    height: 30
                }
                Image {
                    id: smile
                    source: "./images/xiaolian.png"
                    width: 32
                    height: 32
                }
            }

            Row{
                anchors.top: tool_button.bottom
                anchors.topMargin: 5
                id:msg_box
                spacing: 10
                TextArea{
                    id:userInput
                    width: mainRect.width*0.6
                    font.pixelSize: 18
                    placeholderText: "输入消息"
                    wrapMode:TextEdit.Wrap
                    background:Rectangle{
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        implicitWidth: mainRect.width*0.6
                        implicitHeight: 30
                        radius: 10
                        color:"white"
                        border.color: "blue"
                    }
                    onHeightChanged:  {
                        console.log("----=======>mainRect==>height....",mainRect.height)
                        console.log("----=======>userInput==>height....",userInput.height)
                        mainRect.height=(userInput.height/35-1)*35 +90
                        scroll.height=messageBox.height-mainRect.height-41
                    }
                }
                Button{
                    width: send_title.width+20
                    height: send_title.height+10
                    background: Rectangle{
                        radius: 10
                        anchors.fill: parent
                        color: "green"
                        Text {
                            id:send_title
                            anchors.centerIn: parent
                            font.pixelSize: 18
                            color: "white"
                            text: qsTr("发送")
                        }
                    }
                   onClicked: {
                       console.log(userInput.text)
                       sendMsg(userInput.text)
                   }
                }
            }
        }
    }

    Component {
        id: itemCompont
        Row{
             property bool isMe: false
             property string msgText: ""
             property string userName: ""

             property int   gd: 1
             property int   kd: 1
             spacing: 10
             Image {
                visible: isMe?false:true
                width: 30
                height: 30
                id: otherUser
                source: "./images/zhu.png"
             }

             Column{
                Text {
                     id: name
                     font.pixelSize: 12
                     color: "grey"
                     width:  kd
                     text: qsTr(userName)
                     horizontalAlignment:isMe?Text.AlignRight:Text.AlignLeft
                }
                Row{
                     Rectangle {
                       id: compontRect
                        color: isMe?'green':"grey"
                        radius: 10
                        implicitWidth: kd
                        implicitHeight: gd
                       Rectangle {
                           id:arrow
                           width: 15
                           height: 15
                           color: isMe?'green':"grey"
                           rotation: 45
                           anchors.verticalCenter:  parent.verticalCenter
                           anchors.left: isMe?parent.right:parent.left
                           anchors.leftMargin: isMe? -arrow.width:0
                        }
                        Text {
                            anchors.fill: parent
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            id: interText
                            color: "white"
                            font.pixelSize: 16
                            clip :true
                            wrapMode: Text.WrapAnywhere
                            text: qsTr(msgText)
                        }
                     }
                 }
             }
             Image {
                visible: isMe?true:false
                width: 30
                height: 30
                id: meUser
                source: "./images/wo.png"
             }
         }
    }
}


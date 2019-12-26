import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3



Item {


    Rectangle {
        color: "white"
        anchors.fill: parent
    }
    ScrollView{
        background: Rectangle{
        //  color: "lightgrey"
        //  border.color: "red"
        }
        anchors.top: parent.top
        anchors.topMargin: 10
        clip:true
        id:scroll
        width: parent.width
        property ScrollBar hScrollBar: ScrollBar.horizontal
        property ScrollBar vScrollBar: ScrollBar.vertical
        height: parent.height*0.78
        Column{
            spacing: 10
            id:msgText
        }
    }


   Text {
       id: textExample
       color: "red"
       visible: false
       font.pixelSize: 18
       clip: true
       width: parent.width
       height: parent.height
       wrapMode: Text.WrapAnywhere
       text: "hello"
    }

    function sendMsg(sendMsg){
        scroll.vScrollBar.position=1
        if (sendMsg==""){
            return
        }
        textExample.text=sendMsg
        var textGd=textExample.contentHeight+10
        var textKd=textExample.contentWidth+10

        console.log("GD====>",textGd)
        console.log("KD====>",textKd)

        var obj = itemCompont.createObject(msgText, {msgText:sendMsg,gd:textGd,kd:textKd})

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
        height: parent.height*0.2
        width: parent.width
        color: "lightgrey"
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 0
        ColumnLayout{
        spacing: 15
        Row{
            anchors.top: parent.top
            anchors.topMargin: 5
            id:msg
            spacing: 10
            TextArea{
                id:userInput
                width: 300
                font.pixelSize: 18
                placeholderText: "输入消息"
                wrapMode:TextEdit.Wrap
                background:Rectangle{
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    implicitWidth: 300
                    implicitHeight: 30
                    radius: 10
                    color:"white"
                    border.color: "blue"
                }
                onHeightChanged:  {
                    console.log("----=======>mainRect==>height....",mainRect.height)
                    console.log("----=======>userInput==>height....",userInput.height)
                    mainRect.height=(userInput.height/35-1)*35 +90
                }
            }
            Button{
                width: 60
                height: 40
                background: Rectangle{
                    radius: 30
                    anchors.fill: parent
                    color: "green"
                    Text {
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

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30
            Image {
                id: recordVoice
                source: "./luyin.png"
                width: 30
                height: 30
            }

            Image {
                id: pics
                source: "./tupian.png"
                width: 30
                height: 30
            }

            Image {
                id: camera
                source: "./paizhao.png"
                width: 32
                height: 32
            }

            Image {
                id: smile
                source: "./xiaolian.png"
                width: 32
                height: 32
            }

        }

    }
   }


    Component {
        id: itemCompont
          Row{
             property bool isMe: false
             property string msgText: ""
             property int   gd: 1
             property int   kd: 1
             spacing: 10
             Image {
                    visible: isMe?false:true
                    width: 30
                    height: 30
                    id: otherUser
                    source: "./zhu.png"
             }

             Column{
                 Text {
                     id: name
                     font.pixelSize: 12
                     color: "grey"
                     width:  kd
                     text: qsTr("CRF-效率")
                     horizontalAlignment:isMe?Text.AlignRight:Text.AlignLeft
                 }
                Row{
                     Rectangle {
                        width: gd-15
                        height: gd-11
                        color: isMe?'green':"grey"
                        rotation: 46
                        anchors.verticalCenter:  compontRect.verticalCenter
                        anchors.verticalCenterOffset:  0
                        anchors.left: isMe?compontRect.right:compontRect.left
                        anchors.leftMargin: isMe?-20:-2
                     }
                     Rectangle {
                        id: compontRect
                        color: isMe?'green':"grey"
                        radius: 10
                        implicitWidth: kd
                        implicitHeight: gd
                        Text {
                            anchors.top: parent.top
                            anchors.topMargin: 7
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            anchors.right: parent.right
                            anchors.rightMargin: 5
                            horizontalAlignment:Text.AlignHCenter
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
                    source: "./user.png"
              }
          }
   }


}


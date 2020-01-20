import QtQuick 2.12
import QtQuick.Controls 2.5
import QtMultimedia 5.3
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

Item {
    id: window
    anchors.fill: parent
    property bool isLeft:false
    property int  keybordHeight:0
    Connections {
         target: notify
         onKeyBordHeight: {
            keybordHeight=height/screen.devicePixelRatio+1
            if (height>0){
                keybordHeight=height/screen.devicePixelRatio+1
                console.log("onKeyBordHeight=======>",keybordHeight)
                mainRect.anchors.bottomMargin=keybordHeight
                scroll.height=screen.height-(toolbar.height+mainRect.height+keybordHeight)
                console.log("scroll--->height--->",)
                userInput.focus=true
             }
         }
    }

    Rectangle{
      id: mainBox
      anchors.fill: parent
      Rectangle{
          id:toolbar
          height: 42
          width:parent.width
          color:"red"
      }

      ScrollView{
            z:1000
            anchors.top: toolbar.bottom
            background: Rectangle{
                color: "white"
                anchors.fill: parent
            }
            clip:true
            id:scroll
            width: parent.width
            property ScrollBar hScrollBar: ScrollBar.horizontal
            property ScrollBar vScrollBar: ScrollBar.vertical

            height:  Qt.platform.os === "android"?screen.height-(toolbar.height+mainRect.height):screen.desktopAvailableHeight-(toolbar.height+mainRect.height)
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
        Rectangle{
            id: mainRect
            height: 130
            width: parent.width
            color: "#ddd"
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 1
            Row{
                id:msg_box
                anchors.fill: parent
                spacing: 14
                TextArea{
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    id:userInput
                    focus:false
                    visible:true
                    width: mainRect.width*0.6
                    font.pixelSize: 18
                    placeholderText: "输入消息"
                    selectByMouse: true
                    wrapMode:TextEdit.Wrap
                    background:Rectangle{
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        implicitWidth: mainRect.width*0.6
                        implicitHeight: 30
                        radius: 10
                        color:"white"
                    }
                    onHeightChanged:  {
                        console.log("height.......")
                        mainRect.height=(userInput.height/35-1)*35 +90
                        scroll.height=scroll.height-41
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(Qt.platform.os === "android") {
                                if(Qt.inputMethod.visible==false){
                                    userInput.focus=false
                                    Qt.inputMethod.show()
                                }
                            } else{
                                userInput.focus=true

                            }
                        }
                    }
                }

                Button{
                    id:inputButton
                    anchors.left: userInput.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
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
                    MouseArea {
                        anchors.fill: parent
                        id: mouseArea
                        onClicked:{
                           if (userInput.text===""){
                               return
                           }
                           lazyClicked.start();
                        }
                    }
                }


                Button{
                    anchors.left: inputButton.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width: send_title1.width+20
                    height: send_title1.height+10
                    background: Rectangle{
                        radius: 10
                        anchors.fill: parent
                        color: "green"
                        Text {
                            id:send_title1
                            anchors.centerIn: parent
                            font.pixelSize: 18
                            color: "white"
                            text: qsTr("TEST")
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        id: test1
                        onClicked:{
//                            console.log(mainRect.height)
//                            console.log(scroll.height)
//                            scroll.height=scroll.height-100
//                            mainRect.anchors.bottomMargin=100
//                            console.log(scroll.height)
//                             console.log(mainRect.height)
                            notify.openImage("swww")
                        }
                    }
                }



            }
        }
    }

    Timer {
        id: lazyClicked
        interval: 100
        onTriggered: {
            sendMsg(userInput.text)
            userInput.text=""
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
                source: "./zhu.png"
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
                source: "./user.png"
             }
         }
    }


    signal keyboardOpen()
    onKeyboardOpen: {
        if(Qt.platform.os === "android") {
            console.log("===================>",Qt.inputMethod.visible)
            if (Qt.inputMethod.visible==true){
            }else{
                mainRect.anchors.bottomMargin=0
                scroll.height=screen.height-(toolbar.height+mainRect.height)
                userInput.focus=false
            }
        }
    }

    Component.onCompleted: {
        Qt.inputMethod.visibleChanged.connect(keyboardOpen);
        Qt.inputMethod.hide();
       // console.log("screen.height=====",screen.height)
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




}

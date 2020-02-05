import QtQuick 2.12
import QtQuick.Controls 2.5
import QtMultimedia 5.3
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
Page {
   id:msgbox
    property alias text: t.text     // 显示的文字
    width: t.width+20
    height: t.height+20
    z:300
    visible: false
    Rectangle{
        anchors.fill: parent
         color: "black"
          Text {
              id: t
              font.pointSize: 16
              anchors.centerIn: parent
              text: qsTr("msgText")
              color: "red"
          }
          Timer{
            id: msgboxTimer
            interval: 1500; running: false; repeat: true
            onTriggered:{
                msgbox.visible=false
                msgboxTimer.running=false
            }
          }
    }
    function showMsgBox(msg){
         t.text=msg
         msgbox.visible=true
         msgboxTimer.running=true
    }
}

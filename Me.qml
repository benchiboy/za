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

   ///////////////////////////////////
   StackView {
       id: stackView
       anchors.fill: parent
       focus: true
       Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
            stackView.pop()
            event.accepted = true;
       }
       initialItem: Item {
           width: parent.width
           height: parent.height
           Loader{
                id:loader
                anchors.fill: parent
                source: "./MeDetail.qml"
           }
       }
    }

}


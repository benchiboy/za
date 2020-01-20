import QtQuick 2.12
import QtQuick.Controls 2.5
import QtMultimedia 5.3
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.2

Item {
    id: window
    anchors.fill: parent
    GridView
    {
        cellWidth: window.width/3
        cellHeight: window.height/4
        contentWidth: 0
        contentHeight:0
        anchors.fill: parent
        //header:gridHead
        FolderListModel
        {
            id: foldermodel
          // folder: "file:///storage/emulated/0/DCIM/Camera/"
            folder: "file:/Users/liuliangming/Downloads/images/"
            showDirs: true
            showDotAndDotDot: false
            nameFilters: ["*.jpg","*.jpeg"]
            sortField :  "Name"
        }
        Component {
            id: filedelegate
            Rectangle{
                id:itemBox
                width: window.width/3
                height: window.height/4

                 CheckBox {
                       z:1000
                       checked: false
                       //text: qsTr("First")
                   }

                    Image {
                     anchors.fill: parent
                     anchors.centerIn: parent
                      id: name
                       asynchronous: true
                       cache:false
                       sourceSize.width:1000
                       sourceSize.height: 1000
                       source: "file:/Users/liuliangming/Downloads/images/"+fileName
                       //source: "file:///storage/emulated/0/DCIM/Camera/"+fileName
                     }
                MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         itemBox.color="red"
                     }
                }
            }
        }
        model: foldermodel
        delegate: filedelegate
    }

    Component {
        id: gridHead
          Rectangle{
             height: 50;
             width: window.width;
             color: "red"
          }
    }

}

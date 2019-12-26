import QtQuick 2.5
import QtQuick.Layouts 1.1

Rectangle {
    id: icon
    width: columnLayout.width
    height: columnLayout.height
    color: "transparent"

    signal clicked()

    property alias iconTextVisible: iconText.visible
    property size iconSize: Qt.size(33, 33)
    property alias iconText: iconText.text
    property alias activeIconOpacity: activeIconImage.opacity
    property alias activeIconSource: activeIconImage.source
    property alias inactiveIconSource: inactiveIconImage.source

    ColumnLayout {
        id: columnLayout
        anchors.centerIn: parent
        spacing: 0
        Item {
            width:  iconSize.width - iconText.height
            height: iconSize.height - iconText.height
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                id: activeIconImage
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                opacity: 1
                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
            }
            Image {
                id: inactiveIconImage
                anchors.centerIn: parent
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                opacity: 1 - activeIconImage.opacity
            }
        }



        Item {
            height: iconText.contentHeight * 0.3
            width: iconText.contentHeight
        }

    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            icon.clicked();
        }
    }
}

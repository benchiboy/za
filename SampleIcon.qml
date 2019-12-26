import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
    id: icon


    signal clicked()

    height: iconSize.height
    width: iconSize.width

    property size iconSize: Qt.size(33, 33)
    property alias iconSource: iconImage.source

    clip: true

    Image {
        id: iconImage
        sourceSize: iconSize
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignHCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked:  icon.clicked()

    }


}

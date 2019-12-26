import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1

ToolBar {
    id: toolBar
    // #FAFAFA
    property color backgroundColor: "#22292c"
    property var inline: ToolBar {
        id: i
        visible: false
    }

    style: ToolBarStyle {

        padding {
            left: 0
            right: 0
            top: 0
            bottom: 0
        }

        background: Rectangle {
            color: backgroundColor
            implicitWidth: if(isDesktop()) {
                               i.width * 1.2
                           } else {
                               i.width
                           }

            implicitHeight: if(isDesktop()) {
                                i.height * 1.2
                            } else {
                                i.height
                            }
        }
    }

    // [Fix Bug] when a RowLayout anchors.fill TopBar
    Item { anchors.fill: parent }

    function isDesktop () {
        var os = Qt.platform.os;
        if(os === "windows"
                || os === "osx"
                || os === "unix"
                || os === "wince"
                || os === "winrt"
                )
        {
            return true;
        } else {
            return false;
        }
    }
}

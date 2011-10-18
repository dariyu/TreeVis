import QtQuick 1.0

Rectangle {
    BorderImage { clip: true; source: "images/lineedit.sci"; anchors.fill: parent }
    radius: 10
    width: 100
    height: 62
    color: "white"

    property alias text: input.text
    property alias font: input.font
    Text {
        id: input
        clip: true

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 4

        font.pixelSize: 16;
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }
}

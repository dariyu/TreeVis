import QtQuick 1.1

Rectangle {
    id: page

    property Item text: dialogText

    signal closed
    signal opened
    function forceClose() {
        if(page.opacity == 0)
            return;
        page.opacity = 0;
        page.closed();
    }

    function show(txt) {
        dialogText.text = txt;
        page.opacity = 1;
        page.opened();
    }

    width: dialogText.width + 20; height: dialogText.height + 20
    color: "white"
    border.width: 1
    opacity: 0
    visible: opacity > 0
    Behavior on opacity {
        NumberAnimation { duration: 150 }
    }

    Text { id: dialogText; anchors.centerIn: parent; text: "Hello World!" }

    MouseArea { anchors.fill: parent; onClicked: forceClose(); }
}


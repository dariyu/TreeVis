import QtQuick 1.0
import "Core"

Rectangle {
    width: 640
    height: 550

    id: window

    color: "#343434";
    Image { source: "Core/images/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

    TreeVis {
        id: treeContainer
        x: 10
        y: 10

        clip: true
        anchors.left: parent.left
        anchors.right: leftContainer.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 10

        onAnimationOver: {
            setButtonsEnabledValue(true);
        }
    }

    Column {
        id: leftContainer
        spacing: 8
        width: 192
        anchors.right: window.right
        anchors.rightMargin: 10
        anchors.top: window.top
        anchors.topMargin: 10
        anchors.bottom: window.bottom
        anchors.bottomMargin:10



        Column {
            id: inputElementsContainer
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 4

            Text {
                id: txtValue
                anchors.left: parent.left
                anchors.right: parent.right

                text: "Значение:"
                wrapMode: Text.WordWrap
                font.pixelSize: 16;
                font.bold: true;
                color: "white";
                style: Text.Raised;
                styleColor: "black"
                horizontalAlignment: Qt.AlignLeft
            }

            Input {
                id: value
                focus: true
                anchors.left: parent.left
                anchors.right: parent.right
            }
        } // Column inputElementsContainer

        Column {
            id: buttonsContainer
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 4

            Row {
                spacing: 5
                Button {
                    id: butIns
                    text: "Добавить"
                    width: 94
                    height: 25
                    keyUsing: true;
                    opacity: 1

                    onClicked: {
                        var str = value.text;
                        if(str.length <= 0) {
                            return;
                        }

                        var numbers = "0123456789";
                        if(numbers.indexOf(str[0]) == -1 && str[0] != "-" || str[0] == "-" && str.length == 1) {
                            return;
                        }

                        for(var i = 1; i < str.length; i++) {
                            if(numbers.indexOf(str[i]) == -1) {
                                return;
                            }
                        }

                        var insertVal = parseInt(str);
                        if(insertVal > 128 || insertVal < -127) {
                            return;
                        } else {
                            code.sId = 2;
                            variable.setValue(";;;;");
                            setButtonsEnabledValue(false);
                            treeContainer.addElement(insertVal);
                        }
                    }
                }

                Button {
                    id: butFind
                    text: "Найти"
                    width: 94
                    height: 25
                    keyUsing: true;
                    opacity: 1
                    onClicked: {
                        var str = value.text;
                        if(str.length <= 0) {
                            return;
                        }

                        var numbers = "0123456789";
                        if(numbers.indexOf(str[0]) == -1 && str[0] != "-") {
                            return;
                        }

                        for(var i = 1; i < str.length; i++) {
                            if(numbers.indexOf(str[i]) == -1) {
                                return;
                            }
                        }

                        var findVal = parseInt(str);
                        if(findVal > 128 || findVal < -127) {
                            return;
                        } else {
                            code.sId = 3;
                            variable.setValue(";;;;");
                            setButtonsEnabledValue(false);
                            treeContainer.findElement(findVal);
                        }
                    }
                }
            } // Row

            Row {
                spacing: 5
                Button {
                    id: butClear
                    text: "Очистить"
                    width: 94
                    height: 25
                    keyUsing: true;
                    opacity: 1

                    onClicked: {
                        code.sId = 1;
                        variable.setValue(";;;;");
                        treeContainer.clearTree();
                    }
                }
            }// Row
        }// Column buttonsContainer

        Column {
            id: variableViewConteiner
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 4

            Text {
                id: txtVariable
                anchors.left: parent.left
                anchors.right: parent.right

                text: "Значение переменной:"
                font.pixelSize: 16; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
                horizontalAlignment: Qt.AlignLeft
            }

            VariableValueView {
                id: variable
                height: 75

                anchors.left: parent.left
                anchors.right: parent.right
            }
        }// Column variableViewConteiner

        Column {
            id: codeViewContainer
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 4

            Text {
                id: txtCode
                text: "Код:"
                font.pixelSize: 16; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
                horizontalAlignment: Qt.AlignLeft
            }

            CodeView {
                id: code
                anchors.left: parent.left
                anchors.right: parent.right
                height: 280

            }
        }// Column codeViewContainer      
    }

    Image {
        id: imgHelp
        source: "help.png"
        smooth: true
        width: 20
        height: 20

        anchors.right: parent.right
        anchors.top: parent.top

        anchors.rightMargin: 5
        anchors.topMargin: 5

        MouseArea {
            anchors.fill: parent
            onClicked: {
                rectHelp.visible = !rectHelp.visible;
            }
        }
    }

    Rectangle {
        id: rectHelp
        visible: false
        color: "black"
        width: 105
        height: 62
        radius: 5
        clip: true

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 27
        anchors.rightMargin: 5

        Button {
            id: butHelpTheory
            text: "Теория"
            height: 20
            keyUsing: true
            anchors.top: rectHelp.top
            anchors.left: rectHelp.left
            anchors.right: rectHelp.right
            anchors.topMargin: 1

            onClicked: {
                windowContext.openHelpTheory();
            }
        }

        Button {
            id: butHelpUserGuide
            text: "Руководство"
            height: 20
            keyUsing: true
            anchors.top: butHelpTheory.bottom
            anchors.left: rectHelp.left
            anchors.right: rectHelp.right

            onClicked: {
                windowContext.openHelpUserGuide();
            }
        }

        Button {
            id: butHelpCode
            text: "Исходный код"
            height: 20
            keyUsing: true
            anchors.top: butHelpUserGuide.bottom
            anchors.left: rectHelp.left
            anchors.right: rectHelp.right

            onClicked: {
                windowContext.openHelpCode();
            }
        }
    }

    function setButtonsEnabledValue(enabled) {
        butClear.enabled = enabled;
        butFind.enabled = enabled;
        butIns.enabled = enabled;
    }
}

    /* Not now )
    VDots {
        anchors.verticalCenter: window.verticalCenter
        anchors.left: treeContainer.right
        anchors.leftMargin: 1

        color: "white"

    } */

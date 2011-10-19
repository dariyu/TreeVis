import QtQuick 1.0
import "Core"

Rectangle {
    width: 640
    height: 600

    id: window

    color: "#343434";
    Image { source: "Core/images/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

    TreeVis {
        id: treeContainer
        x: 10
        y: 10

        clip: true
        anchors.rightMargin: 225
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent

        onAnimationOver: {
            inputElementsContainer.opacity = 1;
        }
    }

    Column {
        id: inputElementsContainer

        anchors.top: window.top
        anchors.topMargin: 10
        anchors.left: treeContainer.right
        anchors.leftMargin: 10
        anchors.right: window.right
        anchors.rightMargin: 5

        spacing: 10

        Column {
            spacing: 4
            Text {
                text: "Значение:"
                wrapMode: Text.WordWrap
                font.pixelSize: 16; font.bold: true; color: "white";
                style: Text.Raised; styleColor: "black"
                horizontalAlignment: Qt.AlignRight
            }

            Input {
                id: value
                focus: true
            }
        }//Column

        Row {
            spacing: 5
            Button {
                text: "Добавить"
                width: 100
                height: 32
                keyUsing: true;
                opacity: 1

                onClicked: {
                    if(treeContainer.isAnimationLaunch()) {
                        return;
                    }

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
                        inputElementsContainer.opacity = 0.5;
                        treeContainer.addElement(insertVal);
                    }
                }
            }

            Button {
                text: "Найти"
                width: 100
                height: 32
                keyUsing: true;
                opacity: 1
                onClicked: {
                    if(treeContainer.isAnimationLaunch()) {
                        return;
                    }

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
                        inputElementsContainer.opacity = 0.5;
                        treeContainer.findElement(findVal);
                    }
                }
            }
        } // Row

        Row {
            spacing: 5
            Button {
                text: "Очистить"
                width: 100
                height: 32
                keyUsing: true;
                opacity: 1

                onClicked: {
                    if(treeContainer.isAnimationLaunch()) {
                        return;
                    }
                    code.sId = 1;
                    variable.setValue(";;;;");
                    treeContainer.clearTree();
                }
            }
        }// Row

    } // Column

    Rectangle {
        id: codeContainer
        color: "#00000000"
        opacity: 1
        anchors.top: inputElementsContainer.bottom
        anchors.topMargin: 8
        anchors.bottom: window.bottom
        anchors.bottomMargin: 10

        anchors.left: treeContainer.right
        anchors.leftMargin: 10
        anchors.right: window.right
        anchors.rightMargin: 5

        Text {
            id: txtCode
            text: "Код:"
            font.pixelSize: 16; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
            horizontalAlignment: Qt.AlignRight
        }

        CodeView {
            id: code
            focus: true

            anchors.top: txtCode.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: txtVariable.top
            anchors.topMargin: 4
            anchors.bottomMargin: 8
        }

        Text {
            id: txtVariable
            anchors.left: parent.left
            anchors.bottom: variable.top
            anchors.bottomMargin: 4

            text: "Значение переменной:"
            font.pixelSize: 16; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
            horizontalAlignment: Qt.AlignRight
        }

        VariableValueView {
            id: variable
            height: 75

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }
}

    /* Not now )
    VDots {
        anchors.verticalCenter: window.verticalCenter
        anchors.left: treeContainer.right
        anchors.leftMargin: 1

        color: "white"

    } */

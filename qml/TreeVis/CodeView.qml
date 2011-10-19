import QtQuick 1.0

Rectangle {
    BorderImage { source: "Core/images/lineedit.sci"; anchors.fill: parent }

    id: mainCodeRectangle
    width: 180
    height: 200
    radius: 10

    //Переменная для смены "кода" в окошке "кода"
    property int sId: 1

    property int strId: 0

    ListView {
        id: codeList
        anchors.fill: parent
        anchors.margins: 5
        highlightFollowsCurrentItem : true
        highlightMoveDuration: -1
        highlightMoveSpeed: 450

        delegate: codeDelegate
        highlight: Rectangle { color: "lightsteelblue"; radius: 5; opacity: 1 }
        focus: true

        //Модель пустого листа
        ListModel {id: emptyListModel}

        //Строки для вставки
        ListModel {
            id: addListModel
            ListElement {
                //0
                line: "p := root;"
            }
            ListElement {
                key: "ins_whileTrue"
                line: "while (true) do "
            }
            ListElement {
                //2
                line: "begin"
            }
            ListElement {
                key: "ins_ifTreeNull"
                line: "    if (p = nil) then "
            }
            ListElement {
                //4
                line: "    begin"
            }
            ListElement {
                key: "ins_newElem"
                line: "        new(p);"
            }
            ListElement {
                //6
                key: "ins_newElemSetVal"
                line: "        p^.val := newValue;"
            }
            ListElement {
                key: "ins_newElemSetLeftNull"
                line: "        p^.left := nil;"
            }
            ListElement {
                //8
                key: "ins_newElemSetRightNull"
                line: "        p^.right := nil;"
            }
            ListElement {
                key: "ins_complite"
                line: "        exit;"
            }
            ListElement {
                //10
                line: "    end"
            }
            ListElement {
                line: "    else"
            }
            ListElement {
                //12
                key: "ins_ifValueMore"
                line: "        if (newValue < p^.val) then"
            }
            ListElement {
                key: "ins_ifLeft"
                line: "            p := p^.left;"
            }
            ListElement {
                //14
                line: "        else "
            }
            ListElement {
                key: "ins_ifRight"
                line: "            p := p^.right;"
            }
            ListElement {
                //16
                line: "end;"
            }
        }

        //И для поиска тоже строки!
        ListModel {
            id: findListModel
            ListElement {
                line: "p := root;"
            }
            ListElement {
                key: "find_whileTreeNotNull"
                line: "while (p <> nil) do"
            }
            ListElement {
                line: "begin"
            }
            ListElement {
                key: "find_ifValueEqual"
                line: "    if (findValue = p^.val) then"
            }
            ListElement {
                line: "    begin"
            }
            ListElement {
                key: "find_finded"
                line: "        find := true;"
            }
            ListElement {
                key: "find_complite"
                line: "        exit;"
            }
            ListElement {
                line: "    end;"
            }
            ListElement {
                key: "find_ifValueMore"
                line: "    if (findValue < p^.val) then"
            }
            ListElement {
                key: "find_ifLeft"
                line: "        p := p^.left"
            }
            ListElement {
                line: "    else"
            }
            ListElement {
                key: "find_ifRight"
                line: "        p := p^.right;"
            }
            ListElement {
                line: "end;"
            }
            ListElement {
                key: "find_TreeNull"
                line: "find := false;"
            }
        }

        //Делегат отображения элементов листа
        Component {
            id: codeDelegate
            Item {
                width: codeList.width
                height: 16
                Text { text: line }
            }
        }
    }


    //свич "кода" в окошке "кода"
    onSIdChanged: {
        codeList.highlightFollowsCurrentItem = false;
        if (sId == 1) {
            codeList.model = emptyListModel;            
        }
        if (sId == 2) {
            codeList.model = addListModel;
        }
        if (sId == 3) {
            codeList.model = findListModel;
        }
        codeList.currentIndex = 0;
        codeList.highlightFollowsCurrentItem = true;
    }

    onStrIdChanged: {
        codeList.currentIndex = strId;
    }

    function selectLineByKey(key) {
        for(var i = 0; i < codeList.model.count; i++) {
            if(codeList.model.get(i).key == key) {
                codeList.currentIndex = i;
                return;
            }
        }
    }
}


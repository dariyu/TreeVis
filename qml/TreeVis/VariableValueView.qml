import QtQuick 1.0

Rectangle {
    id: mainViewRectangle
    width: 100
    height: 62

    BorderImage { source: "Core/images/lineedit.sci"; anchors.fill: parent }
    radius: 10

    ListView {
        id: valueList
        model: valueListModel
        anchors.fill: parent
        anchors.margins: 5

        delegate: viewDelegate
        focus: true
        ListModel {
            id: valueListModel
            ListElement {
                key: "p"
                value: ""
            }
            ListElement {
                key: "p^.val"
                value: ""
            }
            ListElement {
                key: "p^.left"
                value: ""
            }
            ListElement {
                key: "p^.right"
                value: ""
            }
        }

        //Делегат отображения элементов листа
        Component {
            id: viewDelegate
            Item {
                width: 190
                height: 16
                Text { text: key + " : " + value }
            }
        }
    }

    function setValue(val) {
        var strs = val.split(';');
        for(var i = 0; i < valueList.model.count; i++) {
            valueList.model.get(i).value = strs[i];
        }
    }
}

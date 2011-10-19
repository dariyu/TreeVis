/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0

Item {
    id: container

    signal clicked

    property bool enabled: true
    property string text
    property bool keyUsing: false

    BorderImage {
        id: popImage
        source: "images/toolbutton_pop.sci"
        width: container.width; height: container.height
    }
    BorderImage {
        id: pushImage
        opacity: 0
        source: "images/toolbutton_push.sci"
        width: container.width; height: container.height
    }
    BorderImage {
        id: disabledImage
        opacity: 0
        source: "images/toolbutton_disabled.sci"
        width: container.width; height: container.height
    }
    MouseArea {
        id: mouseRegion
        anchors.fill: popImage
        onClicked: {
            if(container.enabled) {
                container.clicked();
            }
        }
    }
    Text {
        id: btnText
        color: if(container.keyUsing){"#D0D0D0";} else {"#FFFFFF";}
        anchors.centerIn: popImage; font.bold: true
        text: container.text; style: Text.Raised; styleColor: "black"
        font.pixelSize: 12
    }
    states: [
        State {
            name: "Pressed"
            when: ((enabled == true) && (mouseRegion.pressed == true))
            PropertyChanges {
                target: pushImage
                opacity: 1
            }
            PropertyChanges {
                target: popImage;
                opacity: 0
            }
            PropertyChanges {
                target: disabledImage;
                opacity: 0
            }
        },
        State {
            name: "Focused"
            when: container.activeFocus == true
            PropertyChanges {
                target: btnText;
                color: "#FFFFFF"
            }
        },
        State {
            name: "Disabled"
            when: enabled == false
            PropertyChanges {
                target: pushImage
                opacity: 0
            }
            PropertyChanges {
                target: popImage;
                opacity: 0
            }
            PropertyChanges {
                target: disabledImage;
                opacity: 1
            }
            PropertyChanges {
                target: btnText;
                color: "#C0C0C0"
            }
        }

    ]
    transitions: Transition {
        ColorAnimation {
            target: btnText;
        }
    }
}

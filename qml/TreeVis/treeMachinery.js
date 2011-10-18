Qt.include("json2.js");

//корешок
var treeRoot;
//Тут хранятся элементы дерева
var registry = [];
//Эта переменная хранит число элементов плюс единица
var ids = 1;
//Это будет скормлено таймеру в TreeVis.qml
var gSeq = [];

function createBind(target, prop, when, value) {
    var str = "import QtQuick 1.0; Binding {";
    str += "target: " + target + "; ";
    str += "property: \"" + prop + "\"; ";
    str += "when: " + when + "; ";
    str += "value: " + value + "} ";

    bind = Qt.createQmlObject(str);
}

function newLeaf(parent, key, left, right, elem) {
    var element = {"key": key, "parent": parent, "left": left,
                   "right": right, "elem": elem, "id": ids++};
    return element;
}

//генерация объекта шага последовательности
function stepCon(name, value) {
    return {"name" : name, "value" : value};
}

function getValueString(treeLeaf, pval, pleft, pright) {
    var str = "";
    if(pval == "undefined" && pleft == "undefined" && pright == "indefined") {
        str += p + ";" + pval + ";" + pleft + ";" + pright;
    } else if(treeLeaf == null) {
        str += "nil;?;?;?"
    } else {
        str += "[TreeLeaf];" + treeLeaf.key + ";" + ((treeLeaf.left == null) ? "nil;" : "[TreeLeaf];") +  ((treeLeaf.right == null) ? "nil" : "[TreeLeaf]");
    }
    return str;
}

function initTree() {
    treeRoot = null;
}

function insTree(key) {
    var seq = [];

    if(treeRoot == null) {
        seq.push([
                     stepCon("codeline", "ins_whileTrue")
                 ]);
        seq.push([
                     stepCon("codeline", "ins_ifTreeNull"),
                 ]);
        treeRoot = newLeaf(null, key, null, null, null);
        seq.push([
                     stepCon("codeline", "ins_newElem"),
                     stepCon("shownode", treeRoot.id),
                     stepCon("sethigh", treeRoot.id),
                     stepCon("movetohome", treeRoot.id),
                     stepCon("variablevalue", getValueString(treeRoot))
                 ]);
        seq.push([
                     stepCon("codeline", "ins_newElemSetLeftNull"),
                     stepCon("codeline", "ins_newElemSetRightNull"),
                     stepCon("codeline", "ins_newElemSetVal")
                 ]);
        seq.push([
                     stepCon("codeline", "ins_complite")
                 ]);
    } else {
        var tempLeaf = treeRoot;
        while(true) {
            seq.push([
                         stepCon("sethigh", tempLeaf.id),
                         stepCon("variablevalue", getValueString(tempLeaf))
                     ]);
            seq.push([
                         stepCon("codeline", "ins_whileTrue"),
                     ]);
            seq.push([
                         stepCon("codeline", "ins_ifTreeNull"),
                     ]);
            if(tempLeaf.key > key) {
                if(tempLeaf.left == null) {
                    seq.push([
                                 stepCon("codeline", "ins_ifValueMore"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_ifLeft"),
                                 stepCon("unhigh", 0),
                                 stepCon("variablevalue", getValueString(null))
                             ]);
                    tempLeaf.left = newLeaf(tempLeaf, key, null, null, null);
                    tempLeaf = tempLeaf.left;
                    seq.push([
                                 stepCon("codeline", "ins_whileTrue"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_ifTreeNull"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_newElem"),
                                 stepCon("shownode", tempLeaf.id),
                                 stepCon("sethigh", tempLeaf.id),
                                 stepCon("movetohome", tempLeaf.id),
                                 stepCon("variablevalue", getValueString(tempLeaf))
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_newElemSetLeftNull"),
                                 stepCon("codeline", "ins_newElemSetRightNull"),
                                 stepCon("codeline", "ins_newElemSetVal")
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_complite")
                             ]);
                    break;
                } else {
                    seq.push([
                                 stepCon("codeline", "ins_ifValueMore"),
                             ]);
                    tempLeaf = tempLeaf.left;
                    seq.push([
                                 stepCon("codeline", "ins_ifLeft"),
                                 stepCon("sethigh", tempLeaf.id),
                                 stepCon("variablevalue", getValueString(tempLeaf))
                             ]);
                }
            } else {
                if(tempLeaf.right == null) {
                    seq.push([
                                 stepCon("codeline", "ins_ifValueMore"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_ifRight"),
                                 stepCon("unhigh", 0),
                                 stepCon("variablevalue", getValueString(null))
                             ]);
                    seq.push([stepCon("unhigh", 0)]);
                    tempLeaf.right = newLeaf(tempLeaf, key, null, null, null);
                    tempLeaf = tempLeaf.right;
                    seq.push([
                                 stepCon("codeline", "ins_whileTrue"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_ifTreeNull"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_newElem"),
                                 stepCon("shownode", tempLeaf.id),
                                 stepCon("sethigh", tempLeaf.id),
                                 stepCon("movetohome", tempLeaf.id),
                                 stepCon("variablevalue", getValueString(tempLeaf))
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_newElemSetLeftNull"),
                                 stepCon("codeline", "ins_newElemSetRightNull"),
                                 stepCon("codeline", "ins_newElemSetVal")
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_complite")
                             ]);
                    break;
                } else {
                    seq.push([
                                 stepCon("codeline", "ins_ifValueMore"),
                             ]);
                    seq.push([
                                 stepCon("codeline", "ins_ifValueMoreElse")
                             ]);
                    tempLeaf = tempLeaf.right;
                    seq.push([
                                 stepCon("codeline", "ins_ifRight"),
                                 stepCon("sethigh", tempLeaf.id),
                                 stepCon("variablevalue", getValueString(tempLeaf))
                             ]);
                }
            }
        }
    }
    // turn off lights
    seq.push([stepCon("unhigh", 0)]);

    //console.log("\n");
    //console.log(JSON.stringify(seq));
    gSeq = seq.reverse();
}

function findTree(key) {
    var seq = [];

    if(treeRoot == null) {
        seq.push([
                     stepCon("codeline", "find_whileTreeNotNull"),
                     stepCon("variablevalue", getValueString(treeRoot))
                 ]);
        seq.push([
                     stepCon("codeline", "find_TreeNull"),
                 ]);
    } else {
        var tempLeaf = treeRoot;
        while(true) {
            if(tempLeaf != null) {
                seq.push([
                             stepCon("sethigh", tempLeaf.id),
                             stepCon("variablevalue", getValueString(tempLeaf))
                         ]);
            } else {
                seq.push([
                             stepCon("unhigh", 0),
                             stepCon("variablevalue", getValueString(tempLeaf))
                         ]);
            }

            seq.push([
                         stepCon("codeline", "find_whileTreeNotNull"),
                     ]);

            if(tempLeaf != null) {
                seq.push([
                             stepCon("codeline", "find_ifValueEqual")
                         ]);
                if(tempLeaf.key == key) {
                    seq.push([
                                 stepCon("codeline", "find_finded")
                             ]);
                    seq.push([
                                 stepCon("codeline", "find_complite")
                             ]);
                    break;
                }

                seq.push([
                             stepCon("codeline", "find_ifTreeNullElse"),
                             stepCon("codeline", "find_ifValueMore")
                         ]);

                if(tempLeaf.key > key) {
                    tempLeaf = tempLeaf.left;
                    if(tempLeaf != null) {
                        seq.push([
                                     stepCon("codeline", "find_ifLeft"),
                                     stepCon("sethigh", tempLeaf.id),
                                     stepCon("variablevalue", getValueString(tempLeaf))
                                 ]);
                    } else {
                        seq.push([
                                     stepCon("codeline", "find_ifLeft"),
                                     stepCon("variablevalue", getValueString(tempLeaf))
                                 ]);
                    }
                } else {
                    tempLeaf = tempLeaf.right;
                    if(tempLeaf != null) {
                        seq.push([
                                     stepCon("codeline", "find_ifRight"),
                                     stepCon("sethigh", tempLeaf.id),
                                     stepCon("variablevalue", getValueString(tempLeaf))
                                 ]);
                    } else {
                        seq.push([
                                     stepCon("codeline", "find_ifRight"),
                                     stepCon("variablevalue", getValueString(tempLeaf))
                                 ]);
                    }
                }
            } else {
                seq.push([
                             stepCon("codeline", "find_TreeNull"),
                             stepCon("variablevalue", getValueString(tempLeaf))
                         ]);
                break;
            }
        }
    }

  // turn off lights
    seq.push([stepCon("unhigh", 0)]);

    gSeq = seq.reverse();
}

function getTree() {
    return treeRoot;
}

function getHeight() {
    var f = function(tree) {
        if (tree == null)
            return 0;
        else
            return 1 + Math.max(f(tree.left), f(tree.right));
    }

    return f(treeRoot);
}

//Выдёргивает элемент по его id
function getElem(id) {
    for (var i in registry) {
        if (registry[i].id == id)
            return registry[i].element;
    }

    console.log("getElem: no such id --", id);
    return null;
}

function getX(left) {
    return 10 + 40 * left;
}

function getY(top) {
    return 10 + 60 * top;
}

//Считает положения элементов и стрелок в окне программы
function rebuildTree(canvas) {

    var sz = function (tree) {
        if (tree == null)
            return 0;
        var left = sz(tree.left);
        var right = sz(tree.right);
        return left + right > 1 ? left + right : 1;
    }

    var sizes = function (tree, x, y) {
        if (tree == null)
            return 0;
        var left = sizes(tree.left, x, y + 1);
        var right, result;

        right = sizes(tree.right, x +  1.25 + left, y + 1);
        result = left + 1.25 + right;

        //КОСТЫЛЬ
        var x = getX(x + result / 2);
        var y = getY(y);

        tree.elem.x = x;
        tree.elem.y = y;

        var parent = tree.parent;
        if(parent != null) {
            var connector = (parent.left == tree) ? parent.leftConnector : parent.rightConnector;
            if(connector != null) {
                connector.endX = x + tree.elem.height / 2;
                connector.endY = y;
            }
        }

        if(tree.leftConnector != null) {
            tree.leftConnector.startX = x + 5;
            tree.leftConnector.startY = y + tree.elem.height - 5;
        }

        if(tree.leftNullPointer != null) {
            tree.leftNullPointer.startX = x + 5;
            tree.leftNullPointer.startY = y + tree.elem.height - 5;
        }

        if (tree.rightConnector != null) {
            tree.rightConnector.startX = x + tree.elem.width - 5;
            tree.rightConnector.startY = y + tree.elem.height - 5;
        }

        if(tree.rightNullPointer != null) {
            tree.rightNullPointer.startX = x + tree.elem.width - 5;
            tree.rightNullPointer.startY = y + tree.elem.height - 5;
        }
        return result;
    }
    sizes(treeRoot, 0, 0);
}

//отрисовывает элементы
function showElems(canvas) {
    var mf = function(tree) {
        if (tree == null)
            return;
        if(tree.elem == null) {
            tree.elem = Qt.createComponent("TreeElement.qml").createObject(canvas);
            registry.push({"id" : tree.id, "element" : tree.elem});
            tree.elem.x = 10;
            tree.elem.y = 10;
        }
        tree.elem.key = tree.key;
        mf(tree.left);
        mf(tree.right);
    };

    mf(treeRoot);
}

//отрисовывает стрелки, которые добавлены в элемент дерева. если что их можно подсветить
function showArrows(canvas) {
    //Костыль
    var f = function(tree) {
        if(tree == null) {
            return;
        }

        if(tree.left != null) {
            if(tree.leftNullPointer != null) {
                tree.leftNullPointer.destroy();
            }
            if(tree.leftConnector == null) {
                tree.leftConnector = Qt.createComponent("TreeConnector.qml").createObject(canvas);
            }
        } else {
            if(tree.leftNullPointer == null) {
                tree.leftNullPointer = Qt.createComponent("TreeNullPointer.qml").createObject(canvas);
            }
        }

        if(tree.right != null) {
            if(tree.rightNullPointer != null) {
                tree.rightNullPointer.destroy();
            }
            if(tree.rightConnector == null) {
                tree.rightConnector = Qt.createComponent("TreeConnector.qml").createObject(canvas);
            }
        } else {
            if(tree.rightNullPointer == null) {
                tree.rightNullPointer = Qt.createComponent("TreeNullPointer.qml").createObject(canvas);
            }
        }

        f(tree.left);
        f(tree.right);
    }
    f(treeRoot);
}

function clearTree() {
    var ct = function(tree) {
        if (tree == null || tree.elem == null)
            return;
        ct(tree.left);
        ct(tree.right);
        tree.elem.destroy();

        if(tree.leftConnector != null) {
            tree.leftConnector.destroy();
        }

        if (tree.rightConnector != null) {
            tree.rightConnector.destroy();
        }

        if(tree.leftNullPointer != null) {
            tree.leftNullPointer.destroy();
        }

        if (tree.rightNullPointer != null) {
            tree.rightNullPointer.destroy();
        }

        tree = null;
    };

    ct(treeRoot);
    treeRoot = null;
}

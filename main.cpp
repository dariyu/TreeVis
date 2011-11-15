#include <QtGui/QApplication>
#include <QIcon>
#include "qmlapplicationviewer.h"
//(c) mafia

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    viewer.setMinimumHeight(550);
    viewer.setMinimumWidth(500);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);


#ifdef QT_DEBUG
    viewer.setMainQmlFile(QLatin1String("qml/TreeVis/main.qml"));
#else
    viewer.setMainQmlFile(QLatin1String("qml/main.qml"));
#endif
    viewer.showExpanded();

    return app.exec();
}

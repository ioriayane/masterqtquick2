#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "imagecompositor.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<ImageCompositor>("com.example.imagecompositor", 1, 0, "ImageCompositor");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"mygps.h"
#include <QtWebView/QtWebView>
#include <QtQml/QQmlContext>
#include <QTcpServer>
#include "websocket.h"
#include "mytcpsocket.h"
#include "notificationclient.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QtWebView::initialize();

    QQmlApplicationEngine engine;




    const QString initialUrl = "WWW.SOHU.COM";

    QQmlContext *context = engine.rootContext();
    context->setContextProperty(QStringLiteral("initialUrl"),"1111");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    qmlRegisterType<MyGPS>("qiuyuhan.org.MyGps",1,0,"MyGps");


//    MyTcpSocket mySocket;
//    engine.rootContext()->setContextProperty("tcpSocket", &mySocket);

//    MyWebsocket myWebSocket(1234);
//    engine.rootContext()->setContextProperty("webSocket", &myWebSocket);


    #ifdef Q_OS_ANDROID
        NotificationClient notify;
        engine.rootContext()->setContextProperty("notify", &notify);
        notify.updateAndroidNotification();
    #endif

    engine.load(url);


     app.setFont(QFont("Droid Sans Fallback",24));

    return app.exec();
}

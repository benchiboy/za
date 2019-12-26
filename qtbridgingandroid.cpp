#include "qtbridgingandroid.h"
#include <QRect>
#include <QRectF>
#include <QtDebug>
#include <QGuiApplication>

QtBridgingAndroid::QtBridgingAndroid(QObject *parent)
    : QObject(parent)
{

}

void QtBridgingAndroid::sendNotification(const QString &notifyString)
{

#ifdef Q_OS_ANDROID

    #ifdef QT_DEBUG
        qDebug() << "sending... ";
    #endif

    QAndroidJniObject javaNotification = QAndroidJniObject::fromString(notifyString);

    QAndroidJniObject::callStaticMethod<void>("org/za/interface/notification/NotificationClient",
                                              "notify",
                                              "(Ljava/lang/String;)V",
                                              javaNotification.object<jstring>()
                                              );
    Q_SAFE_CALL_JAVA

    #endif

    #ifndef Q_OS_ANDROID
        Q_UNUSED(notifyString)
    #endif
}


#ifdef Q_OS_ANDROID

// 在 Java 中被调用
void QtBridgingAndroid::notifiedKeyboardRectangle(JNIEnv *env, jobject thiz,
                                                  jint x, jint y, jint width, jint height)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)

    if(QGuiApplication::applicationState() != Qt::ApplicationHidden) {

#ifdef QT_DEBUG
        qDebug() << "invoke method notifiedKeyboardRectangle: " <<
#endif
        QMetaObject::invokeMethod(Keyboard::singleton(),
                                  "setKeyboardRectangle",
                                  Qt::AutoConnection,
                                  Q_ARG(QRectF, QRect(x, y, width, height))) ;

    }
}

bool QtBridgingAndroid::registerNativeMethodForJava()
{
    JNINativeMethod methods[] = {
        {
            "notifiedKeyboardRectangle",
            "(IIII)V",
            (void*)&(QtBridgingAndroid::notifiedKeyboardRectangle)
        }
    };


    const char * classname = "org/za/interface/notification/";
    jclass clazz;
    QAndroidJniEnvironment env;

    QAndroidJniObject javaClass(classname);
    clazz = env->GetObjectClass(javaClass.object<jobject>());

    Q_SAFE_CALL_JAVA

    bool result = false;
    if(clazz) {
        jint ret = env->RegisterNatives(clazz,
                                        methods,
                                        sizeof(methods) / sizeof(methods[0]));
        //! [bug] env->DeleteGlobalRef(clazz);
        result = (ret >= 0);
    } else {
    #ifdef QT_DEBUG
            qDebug() << "can't find java class" << classname;
    #endif
    }

    Q_SAFE_CALL_JAVA

    return result;
}

void QtBridgingAndroid::installListener()
{
    #ifdef Q_OS_ANDROID
        // org/gdpurjyfs/wellchat/NotificationClient
        // org/gdpurjyfs/wellchat/QtBridgingAndroid
        // org/gdpurjyfs/sparrow/QtBridgingAndroid
        QAndroidJniObject::callStaticMethod<void>("org/za/interface/notification/NotificationClient",
                                                  "listenKeyboardHeight");
        Q_SAFE_CALL_JAVA
    #endif
}

#endif

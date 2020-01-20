/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtAndroidExtras module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "notificationclient.h"

#include <QtAndroidExtras/QAndroidJniObject>
#include <QAndroidJniEnvironment>
#include <QDebug>
#include <QtAndroid>


static NotificationClient* m_instance{nullptr};


const static QString javaPackage = "org/qtproject/example/notification/"; // Java package


NotificationClient::NotificationClient(QObject *parent)
    : QObject(parent)
{
//   NotificationClientInstance::setInstance(this);
   m_instance=this;
   connect(this, SIGNAL(notificationChanged()), this, SLOT(updateAndroidNotification()));

}
void NotificationClient::setNotification(const QString &notification)
{
    qDebug()<<"====================>";
    m_notification = notification;
    emit notificationChanged();
}

QString NotificationClient::notification() const
{
    return m_notification;
}



void NotificationClient::updateAndroidNotification()
{
    qDebug()<<"updateAndroidNotification====================>";
    m_notification="11111";
    QAndroidJniObject javaNotification = QAndroidJniObject::fromString(m_notification);
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject::callStaticMethod<void>("org/qtproject/example/notification/NotificationClient",
                                       "notify",
                                       "(Ljava/lang/String;Lorg/qtproject/qt5/android/bindings/QtActivity;)V",
                                       javaNotification.object<jstring>(),
                                        activity.object<jobject>());
}


void NotificationClient::openImage(QString path)
{
    qDebug()<<"openImage====================>";
    m_notification="2222";
    QAndroidJniObject javaNotification = QAndroidJniObject::fromString(m_notification);
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject::callStaticMethod<void>("org/qtproject/example/notification/NotificationClient",
                                       "openAnImage",
                                       "(Ljava/lang/String;Lorg/qtproject/qt5/android/bindings/QtActivity;)V",
                                       javaNotification.object<jstring>(),
                                       activity.object<jobject>());


//    QAndroidJniObject action = QAndroidJniObject::getStaticObjectField(
//                   "android/content/Intent",
//                   "ACTION_GET_CONTENT",
//                   "Ljava/lang/String;");


}



 static void onLoginSuccess(JNIEnv */*env*/, jobject /*obj*/,jint height);
 static JNINativeMethod methods[] = {
     {
         "onLoginSuccess",
         "(I)V",
         (void*)onLoginSuccess
     }
 };



 static void onLoginSuccess(JNIEnv */*env*/, jobject /*obj*/,jint height)
 {
     qDebug()<<"====================================>Hello Qt!"<<height;
     emit m_instance->keyBordHeight(height);
 }



JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* /*reserved*/)
{
    qDebug()<<"====================>";
    qDebug()<<JNI_VERSION_1_6;
    JNIEnv* env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
        qDebug()<<"Hello Qt!";
        return JNI_ERR;
    }

    jclass callbackClass = env->FindClass(QString(javaPackage + "QqLoginCallbacks").toUtf8().data());
    if (!callbackClass) {
          qDebug()<<"====================>"<<"QqLoginCallbacks";
        return JNI_ERR;
    }

    if (env->RegisterNatives(callbackClass, methods, sizeof(methods) / sizeof(methods[0])) < 0) {
          qDebug()<<JNI_ERR;
            qDebug()<<"====================>"<<"RegisterNatives";
        return JNI_ERR;
    }

    return JNI_VERSION_1_6;
}


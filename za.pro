QT += quick  webview positioning websockets

android {
    QT += androidextras
    QMAKE_LINK += -nostdlib++
}
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
       # keyboard.cpp \
        main.cpp \
        mygps.cpp \
        mytcpsocket.cpp \
       # qtbridgingandroid.cpp \
        websocket.cpp

android {
    SOURCES += \
        notificationclient.cpp \
}

RESOURCES += qml.qrc

# Additional   import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/assets/about.html \
    android/assets/map.html \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml \ \
    android/src/org/za/interface/notification/NotificationClient.java


android {
    DISTFILES += \
        android/src/org/qtproject/example/notification/NotificationClient.java \
}

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}

HEADERS += \
  #  key_global.h \
  #  keyboard.h \
    mygps.h \
    mytcpsocket.h \
  #  qtbridgingandroid.h \
 #   notificationclient.h \
    websocket.h


android {
    HEADERS += \
        notificationclient.h \
}

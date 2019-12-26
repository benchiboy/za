#ifndef WEBSOCKET_H
#define WEBSOCKET_H


#include <QtCore/QObject>
#include <QtCore/QList>

QT_FORWARD_DECLARE_CLASS(QWebSocketServer)
QT_FORWARD_DECLARE_CLASS(QWebSocket)
QT_FORWARD_DECLARE_CLASS(QString)



class MyWebsocket : public QObject
{
    Q_OBJECT
public:
    MyWebsocket();
    explicit MyWebsocket(quint16 port, QObject *parent = nullptr);
    ~MyWebsocket() override;

private slots:
    void onNewConnection();
    void processMessage(const QString &message);
    void socketDisconnected();


Q_SIGNALS:
    void recvTextMsg (QString lng,QString lat,QString recvMsg);
    void recvVoiceMsg(QString lng,QString lat,QString recvMsg);
    void recvImageMsg(QString lng,QString lat,QString recvMsg);

private:
    QWebSocketServer *m_pWebSocketServer;
    QList<QWebSocket *> m_clients;

};

#endif // WEBSOCKET_H

#include "websocket.h"
#include <QtWebSockets>
#include <QtCore>
#include <QDebug>

static QString getIdentifier(QWebSocket *peer)
{
    return QStringLiteral("%1:%2").arg(peer->peerAddress().toString(),
                                       QString::number(peer->peerPort()));
}

//! [constructor]
MyWebsocket::MyWebsocket(quint16 port, QObject *parent) :
    QObject(parent),
    m_pWebSocketServer(new QWebSocketServer(QStringLiteral("Chat Server"),
                                            QWebSocketServer::NonSecureMode,
                                            this))
{
    if (m_pWebSocketServer->listen(QHostAddress::Any, port))
    {
        QTextStream(stdout) << "Chat Server listening on port " << port << '\n';
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection,
                this, &MyWebsocket::onNewConnection);
    }
}

MyWebsocket::~MyWebsocket()
{
    m_pWebSocketServer->close();
}
//! [constructor]



//! [onNewConnection]
void MyWebsocket::onNewConnection()
{
    auto pSocket = m_pWebSocketServer->nextPendingConnection();
    QTextStream(stdout) << getIdentifier(pSocket) << " connected!"<<endl;
    pSocket->setParent(this);


    connect(pSocket, &QWebSocket::textMessageReceived,
            this, &MyWebsocket::processMessage);
    connect(pSocket, &QWebSocket::disconnected,
            this, &MyWebsocket::socketDisconnected);

    m_clients << pSocket;
}
//! [onNewConnection]

//! [processMessage]
void MyWebsocket::processMessage(const QString &message)
{
    QWebSocket *pSender = qobject_cast<QWebSocket *>(sender());
    for (QWebSocket *pClient : qAsConst(m_clients)) {
        {
            qint64 nLen=  pClient->sendTextMessage(message);
            QString method,lng,lat,context;
            QJsonParseError jsonError;
            QJsonDocument doucment = QJsonDocument::fromJson(message.toUtf8(), &jsonError);  // 转化为 JSON 文档
            if (!doucment.isNull() && (jsonError.error == QJsonParseError::NoError)) {  // 解析未发生错误
                if (doucment.isObject()) { // JSON 文档为对象
                    QJsonObject object = doucment.object();  // 转化为对象
                    if (object.contains("method")) {  // 包含指定的 key
                        QJsonValue value = object.value("method");  // 获取指定 key 对应的 value
                        if (value.isString()) {  // 判断 value 是否为字符串
                            method = value.toString();  // 将 value 转化为字符串
                        }
                    }
                    if (object.contains("lng")) {  // 包含指定的 key
                        QJsonValue value = object.value("lng");  // 获取指定 key 对应的 value
                        if (value.isString()) {  // 判断 value 是否为字符串
                           lng = value.toString();  // 将 value 转化为字符串
                        }
                    }

                    if (object.contains("lat")) {  // 包含指定的 key
                        QJsonValue value = object.value("lat");  // 获取指定 key 对应的 value
                        if (value.isString()) {  // 判断 value 是否为字符串
                            lat = value.toString();  // 将 value 转化为字符串
                        }
                    }

                    if (object.contains("text")) {  // 包含指定的 key
                        QJsonValue value = object.value("text");  // 获取指定 key 对应的 value
                        if (value.isString()) {  // 判断 value 是否为字符串
                            context = value.toString();  // 将 value 转化为字符串
                        }
                    }
                }
            }

            QTextStream(stdout) <<message<<endl;
            if (method=="text"){
                emit recvTextMsg(lng,lat,context);
            } else if (method=="voice"){
                emit recvVoiceMsg(lng,lat,context);
            }else if (method=="image"){
                emit recvImageMsg(lng,lat,context);
            }
        }
    }
}

//! [socketDisconnected]
void MyWebsocket::socketDisconnected()
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    QTextStream(stdout) << getIdentifier(pClient) << " disconnected!\n";
    if (pClient)
    {
       QTextStream(stdout) <<"Remove..."<<pClient<< endl;
        m_clients.removeAll(pClient);
        pClient->deleteLater();
    }
}
//! [socketDisconnected]

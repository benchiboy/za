#ifndef TCPSOCKET_H
#define TCPSOCKET_H

#include <QTcpSocket>
#include <QDataStream>
#include <QNetworkSession>
#include <QBuffer>
#include <QByteArray>
#include <QFile>


class MyTcpSocket : public QObject
{
    Q_OBJECT

public:
    MyTcpSocket();

private slots:
    void connected();
    void readyRead();
    void bytesWritten(qint64 bytes);
    int byteToInt( QByteArray bytes);
    void error(QAbstractSocket::SocketError socketError);

public Q_SLOTS:
     void requestNew();
     void disConnect();
     void sendData();
     void sendFile(QString fileName);
     void getFile();

     void SendTextMsg(QString lng,QString lat,QString strMsg);
     void SendSignInMsg(QString userId);
     QString parserMsg(QByteArray byteArray);
     QByteArray makeHead(int totalLen,int cmdLen);
     QByteArray makePacket(QByteArray cmdJson,QByteArray dataArray,int dataLen);

Q_SIGNALS:
    void conneced();
    void recvTextMsg(QString recvMsg);

private:
    int dataLen=0;
    int HEAD_LEN=10;
    QTcpSocket *tcpSocket = nullptr;

    QDataStream in;
    QDataStream readFile;
    QNetworkSession *networkSession = nullptr;

};

#endif // TCPSOCKET_H

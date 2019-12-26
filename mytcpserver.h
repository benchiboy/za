#ifndef MYTCPSERVER_H
#define MYTCPSERVER_H

#include <QObject>
#include <QAbstractSocket>

class MyTcpServer : public QObject
{
public:
    MyTcpServer();

private slots:
    void sendData();
    void displayError(QAbstractSocket::SocketError socketError);

private:
    QStringList m_oData;
    QTcpServer *m_pTcpServer;
};

#endif // MYTCPSERVER_H

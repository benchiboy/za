#include "mytcpsocket.h"
#include <QDebug>
#include <QJsonObject>
#include <QJsonDocument>
#include <QTime>
//#include <notificationclient.h>
MyTcpSocket::MyTcpSocket()
{
   tcpSocket=new QTcpSocket();
   in.setDevice(tcpSocket);
   in.setVersion(QDataStream::Qt_4_0);

    connect(tcpSocket, &QIODevice::bytesWritten, this, &MyTcpSocket::bytesWritten);
    connect(tcpSocket, &QTcpSocket::connected, this, &MyTcpSocket::connected);
    connect(tcpSocket, &QIODevice::readyRead, this, &MyTcpSocket::readyRead);
    connect(tcpSocket, QOverload<QAbstractSocket::SocketError>::of(&QAbstractSocket::error),this, &MyTcpSocket::error);
}


QString MyTcpSocket::parserMsg(QByteArray byteArray)
{
    QJsonParseError jsonError;
    QJsonDocument doucment = QJsonDocument::fromJson(byteArray, &jsonError);  // 转化为 JSON 文档
    if (!doucment.isNull() && (jsonError.error == QJsonParseError::NoError)) {  // 解析未发生错误
        if (doucment.isObject()) { // JSON 文档为对象
            QJsonObject object = doucment.object();  // 转化为对象
            if (object.contains("method")) {  // 包含指定的 key
                QJsonValue value = object.value("method");  // 获取指定 key 对应的 value
                if (value.isString()) {  // 判断 value 是否为字符串
                    QString strName = value.toString();  // 将 value 转化为字符串
                    qDebug() << "method : " << strName;
                    return  strName;
                }
            }
        }
    }
    return  "";
}


void MyTcpSocket::readyRead()
{
     qDebug() <<"readyRead"<<tcpSocket->bytesAvailable();
     QByteArray head=tcpSocket->read(HEAD_LEN);
     int cmdLen=byteToInt( head.right(8).left(4));
     int dataLen=byteToInt( head.right(8).right(4));
     QByteArray cmdBuf=tcpSocket->read(cmdLen-HEAD_LEN);
     qDebug()<<QString(cmdBuf);
     QString method=parserMsg(cmdBuf);

     if (method=="sign_in_resp"){
         qDebug() << "sign_in_resp : ";
     }

     if (method=="text_msg"){
         qDebug() << "text_msg";
         emit recvTextMsg("hello");
     }

     if (method=="text_msg_resp"){
         qDebug() << "text_msg_resp : ";
         emit recvTextMsg("hello");
     }

}


void MyTcpSocket::bytesWritten(qint64 bytes)
{
    qDebug() << "SimpleTcpSocketClientDemo::bytesWritten " <<bytes;
}

void MyTcpSocket::connected()
{
    qDebug() << "SimpleTcpSocketClientDemo::connected  successfully";
    emit conneced();
}


void MyTcpSocket::error(QAbstractSocket::SocketError socketError)
{
    switch (socketError) {
    case QAbstractSocket::RemoteHostClosedError:
        break;
    case QAbstractSocket::HostNotFoundError:
       qDebug() << tr("Fortune Client The host was not found. Please check the host name and port settings.");
        break;
    case QAbstractSocket::ConnectionRefusedError:
       qDebug() << tr("The connection was refused by the peer. Make sure the fortune server is running, and check that the host name and port settings are correct.");
        break;
     default:
       qDebug() << "other error";
    }
}


void MyTcpSocket::requestNew()
{
     tcpSocket->abort();
     tcpSocket->connectToHost("10.89.4.244", 8089);
     if (!tcpSocket->waitForConnected(100)) {
          qDebug() <<"tcpSocket socker error";
          return;
     }
}

void MyTcpSocket::disConnect()
{
     tcpSocket->disconnectFromHost();
}


QByteArray  intToByte(int number)
{
    QByteArray abyte0;
    abyte0.resize(4);
    abyte0[0] = (uchar)  (0x000000ff & number);
    abyte0[1] = (uchar) ((0x0000ff00 & number) >> 8);
    abyte0[2] = (uchar) ((0x00ff0000 & number) >> 16);
    abyte0[3] = (uchar) ((0xff000000 & number) >> 24);
    return abyte0;
}

int MyTcpSocket::byteToInt( QByteArray bytes)
{
    int i = bytes[3] & 0x000000FF;
    i |= ((bytes[2] )&0x0000FF00);
    i |= ((bytes[1] )&0x00FF0000);
    i |= ((bytes[0] )&0xFF000000);
    return i;
}


void MyTcpSocket::sendData()
{
    qDebug() <<"sendData....";
    QJsonObject json;
    json.insert("method", "up_file");
    json.insert("sn", "00000000000001");
    json.insert("name", "QQ.png");
    QFile file("/Users/liuliangming/Downloads/QQ.png");
    if (!file.open(QIODevice::ReadOnly))
          return;

    tcpSocket->write(file.readAll());

    file.close();

}



void MyTcpSocket::sendFile(QString fileName)
{
    qDebug() <<"sendFile...."<<fileName;
    QJsonObject json;
    json.insert("method", "voice_msg");
    json.insert("from", "a");
    json.insert("to", "b");
    QTime *time = new QTime();
    json.insert("sn",time->currentTime().toString("hh:mm:ss"));
    json.insert("filename", "abc.png");
    QJsonDocument document;
    document.setObject(json);
    QByteArray cmdArray = document.toJson(QJsonDocument::Compact);

    QFile file("/Users/liuliangming/Downloads/"+fileName);
    if (!file.open(QIODevice::ReadOnly))
        return;
    QByteArray packeArray=makePacket(cmdArray,file.readAll(),file.size());
    qDebug() <<"packeLen==>"<< packeArray.length()<<"packetMsg"<<file.size();

    tcpSocket->write(packeArray);

    file.close();

}


void MyTcpSocket::getFile()
{
    QFile file("/Users/liuliangming/Downloads/weixin.png");
    if (!file.open(QIODevice::ReadOnly))
        return;

    QFile apk("/Users/liuliangming/Downloads/weixin-2.png");
    if (!apk.open(QIODevice::WriteOnly))
          return;
    apk.write(file.readAll());
    file.close();
    apk.close();


}



QByteArray MyTcpSocket::makeHead(int totalLen,int cmdLen)
{
    QByteArray abyte0;
    abyte0.append('0x01');
    abyte0.append('0x03');
    abyte0.append(intToByte(totalLen));
    abyte0.append(intToByte(cmdLen));
    return  abyte0;
}

QByteArray MyTcpSocket::makePacket(QByteArray cmdJson,QByteArray dataArray,int dataLen)
{
    QByteArray packArray;
    QByteArray headArray=makeHead(dataLen+cmdJson.length()+HEAD_LEN,cmdJson.length());
    packArray.append(headArray);
    packArray.append(cmdJson);
    if (dataLen>0){
        packArray.append(dataArray);
    }
    return  packArray;
}


void MyTcpSocket::SendTextMsg(QString lng,QString lat,QString strMsg)
{   QJsonObject json;
    json.insert("method", "text_msg");
    json.insert("from", "a");
    json.insert("to", "b");
    json.insert("lng", lng);
    json.insert("lat", lat);

    QTime *time = new QTime();
    json.insert("sn",time->currentTime().toString("hh:mm:ss"));
    json.insert("msg", strMsg);
    QJsonDocument document;
    document.setObject(json);
    QByteArray cmdArray = document.toJson(QJsonDocument::Compact);
    QByteArray packeArray=makePacket(cmdArray,nullptr,0);
    //qDebug() <<"packeLen==>"<< packeArray.length()<<"packetMsg"<<packeArray;
    tcpSocket->write(packeArray);
}

void MyTcpSocket::SendSignInMsg(QString userId)
{   QJsonObject json;
    json.insert("method", "sign_in");
    json.insert("user", userId);
    json.insert("pass", "123456");
    QJsonDocument document;
    document.setObject(json);
    QByteArray cmdArray = document.toJson(QJsonDocument::Compact);
    QByteArray packeArray=makePacket(cmdArray,nullptr,0);
    //qDebug() <<"packeLen==>"<< packeArray.length()<<"packetMsg"<<packeArray;
    tcpSocket->write(packeArray);
}





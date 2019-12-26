#ifndef JSCONTEXT_H
#define JSCONTEXT_H
#include<QObject>


class JsContext : public QObject
{
    Q_OBJECT
public:
    JsContext();
    ~JsContext();

signals:
    void recvdMsg(const QString& msg);

public slots:
    // 接收到页面发送来的消息
    void onMsg(const QString& msg);
};

#endif // JSCONTEXT_H

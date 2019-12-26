#include "jscontext.h"
#include <QDebug>

JsContext::JsContext()
{

}
 JsContext::~JsContext()
{

}


void JsContext::onMsg(const QString &messageData)
{
 qDebug()<<messageData;
}

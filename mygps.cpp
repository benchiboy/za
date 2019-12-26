#include "mygps.h"

MyGPS::MyGPS()
{
    this->gps= QGeoPositionInfoSource::createDefaultSource(0);
    connect(this->gps,SIGNAL(positionUpdated(QGeoPositionInfo)),this,SLOT(GeoUpdate(QGeoPositionInfo)));
}
 MyGPS::~MyGPS()
{
    this->gps->deleteLater();
}
void MyGPS::StartGPS()
{
    this->gps->setUpdateInterval(200);
    this->gps->startUpdates();
}

void MyGPS::GeoUpdate(QGeoPositionInfo gpi)
{
    emit this->update(gpi.coordinate().latitude(),gpi.coordinate().longitude());
}

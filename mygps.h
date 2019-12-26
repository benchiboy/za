#ifndef MYGPS_H
#define MYGPS_H
#include<QObject>
#include<QGeoPositionInfoSource>
class MyGPS:public QObject
{
    Q_OBJECT
private:
    QGeoPositionInfoSource * gps;
signals:
    void update(double latitude,double longtitude);
public:
    MyGPS();
    ~MyGPS();
    Q_INVOKABLE  void StartGPS();
private slots:
    void GeoUpdate(QGeoPositionInfo gpi);
};
#endif

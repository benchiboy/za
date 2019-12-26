import QtQuick 2.0
import QtWebView 1.1
import QtQuick.Controls 2.5
import qiuyuhan.org.MyGps 1.0


import "./component"

Item {

    property string latitude: ""
    property string longtitude: ""

    MyGps{
        id:gps
        onUpdate:{
            lab1.text=latitude.toString()
            lab2.text=longtitude.toString()
            latitude=latitude.toString()
            longtitude=longtitude.toString()
            console.log("-----=======>",latitude,longtitude)
        }//暴露信号的时候需要注意大小写
    }

    Component.onCompleted: {
        //gps.StartGPS();
        tcpSocket.requestNew()
    }

    Connections { // to receive "imageUploaded" signal from the C++ code
         target: tcpSocket
         onRecvTextMsg: {
            console.log("tcpsocket onRecvTextMsg........")
         }
         onConneced: {
            console.log("tcpsocket onConneced........")
            tcpSocket.SendSignInMsg("a")
         }
     }

    Connections { // to receive "imageUploaded" signal from the C++ code
         target: webSocket
         onRecvTextMsg: {
             tcpSocket.SendTextMsg(lng,lat,recvMsg)
         }

         onRecvVoiceMsg: {
             tcpSocket.SendTextMsg(lng,lat,recvMsg)
         }
    }


    TopBar{
            id:topbar
            height: 40


                TextField{
                     id:searchBox
                     width: topbar.width*0.5
                     anchors.centerIn: parent

                     background: Rectangle{
                         anchors.fill: parent
                         radius: 10
                     }
                }


            SampleIcon {
                iconSource:"images/search.png"
                anchors.left: searchBox.right
                anchors.leftMargin: 10
                id: iconButton1
                iconSize: Qt.size( topbar.height - 2,  topbar.height - 2)
                onClicked: {

                }
            }

            SampleIcon {
                iconSource:"images/ditu.png"
                anchors.right: parent.right
                anchors.rightMargin: 20
                id: gpsIcon
                anchors.verticalCenter: parent.verticalCenter
                iconSize: Qt.size( topbar.height - 10,  topbar.height - 10)
                onClicked: {

                }
            }
      }



    WebView {
        id: webview
        anchors.top: parent.top
        anchors.topMargin: 41
        width: parent.width
        height: parent.height-41
       // url:"http://212.64.29.57:9080/pollux/map.html?222222222=11"
        url:"/html/map.html"
        onLoadingChanged: {
          console.log("===============>",loadProgress)
          if (loadRequest.errorString)
           console.error(loadRequest.errorString);
        }
    }

//   Row{
//       id:toolBox
//       anchors.top: parent.top
//       anchors.topMargin: 10
//       z:2000
//      Button{
//        id:socket
//        text:"socket"
//        width: 60
//        height: 40
//         background: Rectangle{
//            color: "red"
//            opacity: 1
//            radius: 10
//        }
//        onClicked: {
//            tcpSocket.requestNew()
//        }
//      }

//       Button{
//        id:websocket
//        text:"websocket"
//        width: 60
//        height: 40
//         background: Rectangle{
//            color: "red"
//            opacity: 1
//            radius: 10
//        }
//        onClicked: {
//            webSocket.requestNew()
//        }
//      }

//       Button{
//        id:msgButton
//        text:"消息1"
//        width: 60
//        height: 40
//         background: Rectangle{
//            color: "red"
//            opacity: 1
//            radius: 10
//        }
//        onClicked: {
//            console.log(burymsg.visible)
//            burymsg.visible=burymsg.visible?false:true
//            webview.runJavaScript("addPoint("+mymap.width+","+mymap.height+")", function() { console.log("result"); });
//        }
//      }

//       Button{
//        text:"语音2"
//        width: 60
//        height: 40
//         background: Rectangle{
//            color: "grey"
//            radius: 10
//          }
//         onClicked: {
//          console.log(latitude)
//          console.log("getAddrByLocation('"+lab2.text+"','"+lab1.text+"')");
//          webview.runJavaScript("getAddrByLocation('"+lab2.text+"','"+lab1.text+"')",function() { console.log("result"); });
//         }
//       }

//       Label{
//               id:lab1
//               z:2000
//               text:"正在加载"

//       }

//       Label{
//               id:lab2
//               z:2000
//               text:"正在加载"

//       }

//   }
}


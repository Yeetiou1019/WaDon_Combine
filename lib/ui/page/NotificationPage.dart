import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget{
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>{
  @override
  Widget build(BuildContext context)
  {
    var DotPosition;
        return new Scaffold(
          body:new Center
          ( child:Card(
            child:Column(
            children:<Widget>[
            Container(
              height: 250.0,
              width: 500.0,
              padding: const EdgeInsets.all(8.0),
              child: Carousel(
                          boxFit: BoxFit.cover,
                          autoplay: true, //自動播放
                          //autoplayDuration: Duration(milliseconds: 100),持續滑動過場時間
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1300),
                          dotSize: 6.0,
                          dotIncreasedColor: Colors.blueGrey,
                          dotBgColor: Colors.transparent,
                          dotPosition: DotPosition(bottom: -10.0),
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      images: [
                        NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                        NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                        ExactAssetImage('image/dog_akitainu.png'),
                      ],
                    ),
                  ),  
                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('系統公告',textAlign: TextAlign.end,style: TextStyle(fontSize: 24.0),),  
                                  ],
                                ),
                  ]
                  )
                   ),
                   )
              );   
            }
          }
          
          Carousel({BoxFit boxFit, bool autoplay, Cubic animationCurve, Duration animationDuration, double dotSize, MaterialColor dotIncreasedColor, Color dotBgColor, dotPosition, double dotVerticalPadding, bool showIndicator, double indicatorBgPadding, List<Object> images}) {
}
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget{
  final String account;
  const ActivityPage({Key key,this.account}) : super(key:key);
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>{
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      body: new Center
      (
        child: new Text("這是活動"),
      ),
    );
  }
}
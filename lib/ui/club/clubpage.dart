import 'package:flutter/material.dart';

class Clubpage extends StatefulWidget {
  @override
  _ClubpageState createState() => _ClubpageState();
}

class _ClubpageState extends State<Clubpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('clubname'),
      ),
    );
  }
}

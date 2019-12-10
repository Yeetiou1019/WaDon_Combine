import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class User extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }),
      title: Text('使用者頁面'),
    ),
      body:_body(), 
    );
  }
}

_body(){
return SingleChildScrollView(
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
              children: [
                _profile(),
              ]),
        ),
      ),
    );
}


_profile(){
return  Column(
        children: <Widget>[
          Image.asset('assets/man.jpg'),
          Container(
              width: 190,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: const AssetImage('assets/man.jpg')))),
          Column(
            children: <Widget>[
              Container(
                child: FractionallySizedBox(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[Text('姓名:')],
                              ),
                              Row(
                                children: <Widget>[Text('學號:')],
                              ),
                              Row(
                                children: <Widget>[Text('電話:')],
                              ),
                              Row(
                                children: <Widget>[Text('性別:')],
                              ),
                              Row(
                                children: <Widget>[Text('系所:')],
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[Text('李小熊')],
                              ),
                              Row(
                                children: <Widget>[Text('1105137246')],
                              ),
                              Row(
                                children: <Widget>[Text('0968686868')],
                              ),
                              Row(
                                children: <Widget>[Text('男')],
                              ),
                              Row(
                                children: <Widget>[Text('智慧商務系')],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
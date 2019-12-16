import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:wadone_main/bloc/userbloc.dart';

class User extends StatefulWidget {
  final String account;
  const User({Key key, this.account}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<User> {
  Userbloc bloc;

  @override
  void didChangeDependencies() {
    bloc = Provider.of<Userbloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
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
                title: Text(snapshot.data['name'] + '你好'),
              ),
              body: SingleChildScrollView(
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
                          Column(
                            children: <Widget>[
                              Image.asset('assets/dog_akitainu.png'),
                              Container(
                                  width: 190,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: const AssetImage(
                                              'assets/dog_akitainu.png')))),
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: FractionallySizedBox(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text('學號: '+snapshot.data['name'])
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('電子信箱: '+snapshot.data['name'])
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('電話: '+snapshot.data['name'])
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('性別: '+snapshot.data['name'])
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('系所: '+snapshot.data['name'])
                                                    ],
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
                          ),
                        ]),
                  ),
                ),
              ));
        });
  }
}
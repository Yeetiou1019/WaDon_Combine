import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:wadone_main/bloc/managerbloc.dart';
import 'package:wadone_main/bloc/pagebloc.dart';
import 'package:wadone_main/bloc/userbloc.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:wadone_main/ui/manager/create.dart';
import 'package:wadone_main/ui/manager/edit.dart';
import '../../page/profile/logout_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication_bloc/bloc/bloc.dart';

class ProfilePage extends StatefulWidget {
  final String account;
  ProfilePage({Key key, this.account}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
  
}



class _ProfilePageState extends State<ProfilePage> {
  PageBloc bloc;
  Userbloc userbloc;
  Managerbloc _bloc;

  void didChangeDependencies() async {
    super.didChangeDependencies();
    bloc = Provider.of<PageBloc>(context);
    userbloc = Provider.of<Userbloc>(context);
    _bloc = Provider.of<Managerbloc>(context);
    userbloc.changeaccount(widget.account);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
          stream: userbloc.getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (userbloc.judge(snapshot.data['property'])) {
              return Column(
                children: <Widget>[
                  Flexible(
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(child: clubINFO()),
                          ],
                        ),
                        actlistview()
                      ],
                    )),
                  ),
                  LogoutButton(
                    onPressed: () =>
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut()),
                  ),
                ],
              );
            } else {
              ///user
              return Column(
                children: <Widget>[
                  Flexible(
                    child: StreamBuilder(
                        stream: userbloc.getUserData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Scaffold(
                              body: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              _background(),
                              SingleChildScrollView(
                                child: AnimationLimiter(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        AnimationConfiguration.toStaggeredList(
                                            duration: const Duration(
                                                milliseconds: 375),
                                            childAnimationBuilder: (widget) =>
                                                SlideAnimation(
                                                  horizontalOffset: 50.0,
                                                  child: FadeInAnimation(
                                                    child: widget,
                                                  ),
                                                ),
                                            children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 90.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Container(
                                                  width: 200.0,
                                                  height: 200.0,
                                                  decoration: new BoxDecoration(
                                                    color:
                                                        const Color(0xff7c94b6),
                                                    image: new DecorationImage(
                                                      image: ExactAssetImage(
                                                          'assets/man.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            new Radius.circular(
                                                                200.0)),
                                                    border: new Border.all(
                                                      color: Colors.white,
                                                      width: 4.0,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                  children: <Widget>[
                                                    Text('姓名:'+snapshot.data['name'],
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text('學號:'+snapshot.data['studentID'],
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text('電話:'+snapshot.data['tel'],
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text('性別:'+snapshot.data['gender'],
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text('系所:'+snapshot.data['club'],
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text('信箱:'+snapshot.data['email'],
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ));
                        }),
                  ),
                  LogoutButton(
                    onPressed: () =>
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut()),
                  ),
                ],
              );
            }
          }),
    );
  }

  _background() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/man.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }

  Widget actlistview() {
    return Flexible(
      child: StreamBuilder(
        stream: bloc.activeList(), //that club's active
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasData) {
            List<DocumentSnapshot> docs = snap.data.documents;
            List<Detail> goalsList = bloc.detailToList(docList: docs);
            if (goalsList.isNotEmpty) {
              return buildList(goalsList);
            } else {
              return Text("data doesn't exist");
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView buildList(List<Detail> goalsList) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: goalsList.length,
        itemBuilder: (context, index) {
          // final id = goalsList[index].description;
          final detail = goalsList[index]; //catch this active
          return InkWell(
            child: ListTile(
              title: Text(
                detail.title,

                ///活動名稱
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('主辦單位 : ' + detail.club),

              ///社團名稱
              trailing: Text(
                detail.statue,

                ///活動狀態
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                    onPressed: () {
                      ///only act owner can do this method
                      /// so give this method an club's id
                      String clubid = 'NKUST_IC';

                      ///fortemp this will catch that club's id(after singing)
                      _bloc.delete(clubid, detail.actid);

                      ///add to personal list
                    },
                  );
                },
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Edit(
                    detail: detail,
                  ),
                ),
              );
            },
          );
        });
  }

  Widget create() {
    return RaisedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Create(),
          ),
        );
      },
      icon: Icon(Icons.control_point),
      label: Text('新增活動'),
      color: Colors.orangeAccent,
    );
  }

  Widget clubINFO() {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '系所:智慧商務系',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '所屬:系委',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '社團簡介：智商系致力於................',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                      ),
                    ),
                    create(),
                  ],

                  ///build info
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ProfilePage extends StatefulWidget {
//   final String account;
//   const ProfilePage({Key key,this.account}) : super(key:key);
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: <Widget>[
//           RaisedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Manager(),
//                 ),
//               );
//             },
//             child: Text('Manager Page'),
//           ),
//           RaisedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => User(),
//                 ),
//               );
//             },
//             child: Text('User Page'),
//           ),
//           Container(
//             child: Column(
//               children: <Widget>[
//                 LogoutButton(
//                   onPressed:()=> BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

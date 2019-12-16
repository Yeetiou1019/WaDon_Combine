import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:wadone_main/bloc/pagebloc.dart';
import 'package:wadone_main/models/detail.dart';
import 'activeDetailPage.dart';

class ActivityPage extends StatefulWidget {
  final String account;
  const ActivityPage({Key key, this.account}) : super(key: key);
  @override
  _ActivityPageState createState() {
    return _ActivityPageState();
  }
}

class _ActivityPageState extends State<ActivityPage> {
  PageBloc pageBloc;
  TextEditingController myController = TextEditingController();

  void didChangeDependencies() async {
    super.didChangeDependencies();
    pageBloc = Provider.of<PageBloc>(context);
  }

  @override
  initState()  {
    super.initState();
  }

  @override
  void dispose() {
    //pageBloc.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                  children: [body()]),
            ),
          ),
        ));
  }

  Future getallClub() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('posts').getDocuments();
    return qn.documents;
  }

  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Flexible(
            child: FutureBuilder(
              future: getallClub(),
              builder: (BuildContext context, snap) {
                if (snap.hasData) {
                  List<DocumentSnapshot> docs = snap.data;
                  List<String> idlist = pageBloc.getclubId(docList: docs);
                  if (idlist.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: idlist.length,
                      itemBuilder: (context, index) {
                        final clubid = idlist[index];
                        return Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: <Widget>[
                                ///show actList
                                Flexible(
                                  child: StreamBuilder(
                                    stream: pageBloc.entireActList(clubid),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snap) {
                                      if (snap.hasData) {
                                        List<DocumentSnapshot> docs =
                                            snap.data.documents;
                                        List<Detail> goalsList = pageBloc
                                            .detailToList(docList: docs);
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
                                ),
                              ],
                            ));
                      },
                    );
                  } else {
                    return Text("data doesn't exist");
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }


  ListView buildList(List<Detail> goalsList) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: goalsList.length,
        itemBuilder: (context, index) {
          // final id = goalsList[index].description; //catch this active
          return InkWell(
            child: ListTile(
              title: Text(
                goalsList[index].title,

                ///活動名稱
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('主辦單位 : ' + goalsList[index].club),

              ///社團名稱
              trailing: Text(
                goalsList[index].statue,

                ///活動狀態
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActiveDetailPage(
                      detail: goalsList[index], account: widget.account),
                ),
              );
            },
          );
        });
  }
}
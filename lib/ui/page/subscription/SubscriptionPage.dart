import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wadone_main/bloc/managerbloc.dart';
import 'package:wadone_main/bloc/pagebloc.dart';
import 'package:wadone_main/models/club.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:wadone_main/ui/page/activity/activeDetailPage.dart';
import 'package:wadone_main/ui/page/subscription/DetailSubscription.dart';

class SubscriptionPage extends StatefulWidget {
  final String account;
  const SubscriptionPage({Key key, this.account}) : super(key: key);
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  Managerbloc _bloc;
  PageBloc pageBloc;
  TextEditingController myController = TextEditingController();

  void didChangeDependencies() async {
    super.didChangeDependencies();
    _bloc = Provider.of<Managerbloc>(context);
    pageBloc = Provider.of<PageBloc>(context);
    pageBloc.useraccount(widget.account);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    pageBloc.dispose();
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
                  children: [
                    // _buildAppbar(),
                    clubstreambuilder(),
                    // actstreambuilder(),
                  ]),
            ),
          ),
        ));
  }

  Widget clubstreambuilder() {
    return Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                  stream: pageBloc.subscribeList(widget.account),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snap) {
                    if (snap.hasData) {
                      List<DocumentSnapshot> docs = snap.data.documents;
                      List<Club> clublist =
                          pageBloc.mapClubInfo(docList: docs);
                      if (docs.isNotEmpty) {
                        return buildClubTAB(clublist);
                      } else {
                        return Text("data doesn't exist");
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ));
  }

      ListView buildClubTAB(List<Club> clublist) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: clublist.length,
        itemBuilder: (context, index) {
          // final id = goalsList[index].description;
          final club = clublist[index]; //catch this active
          return InkWell(
            child: ListTile(
              title: CircleAvatar(
                    child:ClipOval(
                      child: Image.network(club.pic),
                    ),
                    backgroundImage: NetworkImage(club.pic),
                  ),
              subtitle: Text('id : ' + club.id),
              trailing: Text(
                club.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailSubscription(
                    club: club,
                  ),
                ),
              );
            },
          );
        },
        
        
        );
  }

  Widget actstreambuilder() {
    return Container(
        height: 200,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: StreamBuilder(
                  stream: pageBloc.subscribeAct(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snap) {
                    if (snap.hasData) {
                      List<DocumentSnapshot> docs = snap.data.documents;
                      List<Detail> clublist =
                          pageBloc.detailToList(docList: docs);
                      if (docs.isNotEmpty) {
                        return buildActList(clublist);
                      } else {
                        return Text("data doesn't exist");
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ));
  }

  ListView buildActList(List<Detail> goalsList) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: goalsList.length,
        itemBuilder: (context, index) {
          // final id = goalsList[index].description;
          final detail = goalsList[index]; //catch this active
          return InkWell(
            child: ListTile(
              title: Text(
                detail.title,///活動名稱
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,),
              ),
              subtitle: Text('主辦單位 : '+detail.club),///社團名稱
              trailing: Text(
                detail.statue,///活動狀態
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
                    detail: detail,
                  ),
                ),
              );
            },
          );
        });
  }

  _buildAppbar() {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildclub(),
          _buildclub(),
          _buildclub(),
          _buildclub()
        ],
      ),
    );
  }

  _buildclub() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0), //App bar間隔
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            // backgroundImage: ExactAssetImage('assets/mypost.png'),
          ),
          Text("社團名稱"),
        ],
      ),
    );
  }

    _buildact() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '109年度資管DA',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 24.0),
                        ),
                        Text('已報名'),
                      ],
                    ),
                    Row(
                      children: <Widget>[Text('主辦單位：資訊管理系（建工校區）')],
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

}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wadone_main/bloc/pagebloc.dart';
import 'package:wadone_main/models/club.dart';
import 'package:wadone_main/bloc/userbloc.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:wadone_main/ui/page/activity/activeDetailPage.dart';

class DetailSubscription extends StatefulWidget {
  Club club;
  String account;
  DetailSubscription({Key key, @required this.club,this.account}) : super(key: key);
  @override
  _DetailSubscriptionState createState() => _DetailSubscriptionState();
}

class _DetailSubscriptionState extends State<DetailSubscription> {
  Userbloc user;
  PageBloc pageBloc;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    pageBloc = Provider.of<PageBloc>(context);
    user = Provider.of<Userbloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:Text(widget.club.name),
      ),
      body:StreamBuilder(
      stream: user.clubpost(widget.club.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot != null) {
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<Detail> actList = pageBloc.detailToList(docList: docs);
          if (actList.isNotEmpty) {
            return buildList(actList);
          } else {
            return Text("data doesn't exist");
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }

  ListView buildList(List<Detail> goalsList) {
    return  ListView.separated(
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
                    account: widget.account,
                  ),
                ),
              );
            },
          );
        });
  }
}

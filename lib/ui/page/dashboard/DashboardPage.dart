import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wadone_main/bloc/pagebloc.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:wadone_main/ui/page/activity/activeDetailPage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:wadone_main/ui/page/activity/ActivityPage.dart';

class DashboardPage extends StatefulWidget {
  final String account;
  const DashboardPage({Key key, this.account}) : super(key: key);
  @override
  _DashboardState createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<DashboardPage> {
  PageBloc pageBloc;

  void didChangeDependencies() async {
    super.didChangeDependencies();
    pageBloc = Provider.of<PageBloc>(context);
  }

  @override
  void dispose() {
    pageBloc.dispose();
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
                  children: [
                    buildTextfield(),
                    buttonGroup(),
                    buildCarousel(),
                    body()
                  ]),
            ),
          ),
        ));
  }

  Widget body() {
    return Container(
        height: 800,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: StreamBuilder(
                  stream: pageBloc.activeList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snap) {
                    if (snap.hasData) {
                      List<DocumentSnapshot> docs = snap.data.documents;
                      List<Detail> goalsList =
                          pageBloc.detailToList(docList: docs);
                      if (goalsList.isNotEmpty) {
                        return buildList(goalsList);
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

  Widget buildCarousel() {
    return Container(
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
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: [
          NetworkImage(
              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
          NetworkImage(
              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
        ],
      ),
    );
  }
}

Widget buildTextfield() {
  return TextField(
    maxLines: 1,
    decoration: new InputDecoration(
        hoverColor: Color.fromARGB(255, 50, 50, 200),
        icon: Icon(
          Icons.search,
        ),
        hintText: ("搜尋"),
        border: InputBorder.none),
  );
}

Widget buttonGroup() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      buildbutton(),
      buildbutton(),
      buildbutton(),
      buildbutton(),
    ],
  );
}

Widget buildbutton() {
  ///foreach and build every #hastags from firestore
  return OutlineButton(
      hoverColor: Colors.grey[800],
      borderSide: BorderSide(
        color: Colors.cyan[300],
      ),
      child: new Text("#活動"),
      textColor: Colors.blueGrey,
      onPressed: () {},
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(40.0)));
}

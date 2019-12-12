import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:wadone_main/bloc/pagebloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/animated_button.dart';

class ActiveDetailPage extends StatefulWidget {
  final Detail detail;
  final String account;
  ActiveDetailPage({Key key, @required this.detail, this.account})
      : super(key: key);

  @override
  _ActiveDetailPageState createState() => _ActiveDetailPageState();
}

// Future<String> loadAsset() async {
//   return await rootBundle.loadString('assets/config.json');
// }

class _ActiveDetailPageState extends State<ActiveDetailPage> {
  PageBloc _bloc;

  get btnOkText => null;

  get btnCancelText => null;

  get btnCancelColor => null;

  get btnCancelIcon => null;

  get btnOkIcon => null;

  get btnOkColor => null;
  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<PageBloc>(context);
    _bloc.thisactiveId(widget.detail.actid);
    _bloc.clubId(widget.detail.club);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _body1(),
      bottomNavigationBar: _raisedButton(),
    );
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder(
          stream: _bloc.allact(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasData) {
              List<DocumentSnapshot> docs = snap.data.documents;
              List<Detail> detailsList = _bloc.detailToList(docList: docs);
              if (detailsList.isNotEmpty) {
                return Column(
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [_content(detailsList)]),
                );
              } else {
                return Text("data doesn't exist");
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget _content(List<Detail> detailsList) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,

        ///如果有設定高度 而且是像listview這種會產生很多個的 記得在 子widget 下面用以上這兩個 會自動 match 父widget 的大小 error:Vertical viewport was given unbounded height.
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: detailsList.length,
        itemBuilder: (context, index) {
          // DocumentSnapshot doc = detailsList[index];
          return Center(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    detailsList[index].pname,

                    ///活動名稱
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  _subbutton()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '活動時間：108年12月25號 (修但幾勒)',

                          ///暫時沒辦法
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '活動時間：17：30~21：00 (金罵謀銀)',

                          ///暫時沒辦法
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '活動地點：' + detailsList[index].localtion,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '活動備注：' + detailsList[index].note,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '活動内容：' + detailsList[index].description,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          child: Image.asset('assets/dog_akitainu.png'),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ));
        });
  }

  Widget _raisedButton() {
    if (0 == 0) {
      ///判斷有無報名過
      return RaisedButton(
        color: Colors.cyan[800],
        textColor: Colors.white,
        onPressed: () {
          _dialog();

          ///user add act to actlist
          Firestore.instance
              .collection('users')
              .document(widget.account)
              .collection('actlist')
              .document(widget.detail.actid)
              .setData({
            'actid': widget.detail.actid,
            'time': Timestamp.fromDate(DateTime.now())
          });

          ///act add user to userlist
          Firestore.instance
              .collection('posts')
              .document(widget.detail.club)
              .collection('club_post')
              .document(widget.detail.actid)
              .collection('userlist')
              .document(widget.account)
              .setData({
            'u_id': widget.account,
            'time': Timestamp.fromDate(DateTime.now())
          });
        },
        child: Text('報名'),
      );
    } else {
      return RaisedButton(
        color: Colors.cyan[800],
        textColor: Colors.white,
        onPressed: () {},

        ///FUTTER TOAST 提示 '親 您已經報名過了喔 揪咪><' 之類的
        child: Text('已報名'),
      );
    }
  }

  Widget _body1() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          floating: true,
          pinned: true,
          snap: true,
          expandedHeight: 500, //必须设定,否则无法显示
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.detail.title,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            background: Image.asset(
              "assets/dog_akitainu.png",
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _body();
          },
          childCount: 1,
        ))
      ],
    );
  }

  _subbutton() {
    return RaisedButton(
        color: Colors.blueGrey,
        textColor: Colors.white,
        onPressed: () {},

        /// add this actid to suscript list
        child: Row(
          children: <Widget>[
            Text('訂閲'),
            Icon(Icons.add_circle_outline),
          ],
        ));
  }

  _dialog() {
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: Text(
          '您是否要報名?',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      tittle: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOk: _buildFancyButtonOk(),
      btnCancel: _buildFancyButtonCancel(),
      btnOkOnPress: () {},
    ).show();
  }

  _buildFancyButtonOk() {
    return AnimatedButton(
      pressEvent: () {
        Navigator.of(context).pop();
        btnOkOnPress();
      },
      text: btnOkText ?? '確定',
      color: btnOkColor ?? Color(0xFF00CA71),
      icon: btnOkIcon,
    );
  }

  _buildFancyButtonCancel() {
    return AnimatedButton(
      pressEvent: () {
        Navigator.of(context).pop();
        btnCancelOnPress();
      },
      text: btnCancelText ?? '取消',
      color: btnCancelColor ?? Colors.red,
      icon: btnCancelIcon,
    );
  }

  void matchId() {}

  void btnOkOnPress() {}

  void btnCancelOnPress() {}
}

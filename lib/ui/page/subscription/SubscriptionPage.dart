import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wadone_main/bloc/managerbloc.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key key}) : super(key:key);
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  Managerbloc _bloc;
  TextEditingController myController = TextEditingController();

  void didChangeDependencies() async {
    super.didChangeDependencies();
    _bloc = Provider.of<Managerbloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Future<bool> _onWillPop() {
    Navigator.pop(context, false);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      clubField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      idField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      nameField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      titleField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      contentField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      clublimitField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      numlimitField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      statueField(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      plocaltion(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      pnote(),
                      Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      // actstartField(),
                      // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      // actendField(),
                      // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      // singupField(),
                      // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      // singendField(),
                      // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      // statueField(),
                      // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                      submitButton(),
                    ],
                  ))),
            )),
      ),
    );
  }

  Widget button() {
    return StreamBuilder(
      stream: _bloc.showProgress,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return submitButton();
        } else {
          if (!snapshot.data) {
            return submitButton();
          } else {
            return CircularProgressIndicator();
          }
        }
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
        textColor: Colors.white,
        color: Colors.black,
        child: Text("Submit"),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
          _bloc.submit();
        });
  }


  Widget pnote() {
    return StreamBuilder(
        stream: _bloc.pnote,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changepnote,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '活動備註',
                errorText: snapshot.error),
          );
        });
  }


Widget plocaltion() {
    return StreamBuilder(
        stream: _bloc.plocaltion,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeplocaltion,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '活動地點',
                errorText: snapshot.error),
          );
        });
  }


  Widget idField() {
    return StreamBuilder(
        stream: _bloc.pid,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeid,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '活動ID',
                errorText: snapshot.error),
          );
        });
  }

  Widget nameField() {
    return StreamBuilder(
        stream: _bloc.pname,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changepname,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '活動名稱',
                errorText: snapshot.error),
          );
        });
  }

  Widget clubField() {
    return StreamBuilder(
        stream: _bloc.clubid,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeclubid,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '這個社團的id',
                errorText: snapshot.error),
          );
        });
  }

  Widget titleField() {
    return StreamBuilder(
        stream: _bloc.ptitle,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeptitle,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '大標',
                errorText: snapshot.error),
          );
        });
  }

  Widget contentField() {
    return StreamBuilder(
        stream: _bloc.pcontent,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changepcontent,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '形容此活動',
                errorText: snapshot.error),
          );
        });
  }

  Widget clublimitField() {
    return StreamBuilder(
        stream: _bloc.clublimit,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeclublimit,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '限制那些社團',
                errorText: snapshot.error),
          );
        });
  }

  Widget numlimitField() {
    return StreamBuilder(
        stream: _bloc.numlimit,
        ///type(num)
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changenumlimit,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '限制數量',
                errorText: snapshot.error),
          );
        });
  }

  Widget statueField() {
    return StreamBuilder(
        stream: _bloc.statue,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeststue,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: '活動狀態',
                errorText: snapshot.error),
          );
        });
  }
}



//   Widget actstartField() {
//     return StreamBuilder(
//         stream: _bloc.actstart,
//         builder: (context, AsyncSnapshot<Timestamp> snapshot) {
//           return TextField(
//             onChanged: _bloc.changeid,
//             obscureText: false,
//             decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10.0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 hintText: 'enter something',
//                 errorText: snapshot.error),
//           );
//         });
//   }

//   Widget actendField() {
//     return StreamBuilder(
//         stream: _bloc.pid,
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           return TextField(
//             onChanged: _bloc.changeid,
//             obscureText: false,
//             decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10.0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 hintText: 'enter something',
//                 errorText: snapshot.error),
//           );
//         });
//   }

//   Widget singupField() {
//     return StreamBuilder(
//         stream: _bloc.pid,
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           return TextField(
//             onChanged: _bloc.changeid,
//             obscureText: false,
//             decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10.0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 hintText: 'enter something',
//                 errorText: snapshot.error),
//           );
//         });
//   }

//   Widget singendField() {
//     return StreamBuilder(
//         stream: _bloc.pid,
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           return TextField(
//             onChanged: _bloc.changeid,
//             obscureText: false,
//             decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10.0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 hintText: 'enter something',
//                 errorText: snapshot.error),
//           );
//         });
//   }
// }
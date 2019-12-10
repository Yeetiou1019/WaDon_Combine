import 'package:flutter/material.dart';
import 'package:wadone_main/bloc/managerbloc.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  final Detail detail;
  Edit({Key key, @required this.detail}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  Managerbloc _bloc;
  TextEditingController myController = TextEditingController();

  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<Managerbloc>(context);
    _bloc.changeclubid(widget.detail.club);
    _bloc.changeid(widget.detail.actid);
    _bloc.changeststue(widget.detail.statue);
    _bloc.changepname(widget.detail.pname);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Edit ' + widget.detail.title + ' data'),
      ),
      body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              // clubField(),
              // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              // idField(),
              // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              // nameField(),
              // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              titleField(),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              contentField(),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              clublimitField(),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              numlimitField(),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              // statueField(),
              // Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
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
              submitButton(),
            ],
          ))),
    );
  }

  Widget submitButton() {
    return RaisedButton(
        textColor: Colors.white,
        color: Colors.black,
        child: Text("Complete"),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
          _bloc.update();
          Navigator.pop(context) ;
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
                labelText: '活動備註',
                hintText:"先前輸入 :"+widget.detail.note,
                errorText: snapshot.error),
                
          );
        });
  }

  Widget numlimitField() {
    return StreamBuilder(
        stream: _bloc.numlimit,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changenumlimit,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: '限制數量',
                hintText:"先前輸入 :"+widget.detail.numlimit,
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
                labelText: '活動地點',
                hintText:"先前輸入 :"+widget.detail.localtion,
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
                labelText: '大標',
                hintText:"先前輸入 :"+widget.detail.title,
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
                labelText: '形容此活動',
                hintText:"先前輸入 :"+widget.detail.description,
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
                labelText: '限制那些社團',
                hintText:"先前輸入 :"+widget.detail.clublimit,
                errorText: snapshot.error),
          );
        });
  }





}
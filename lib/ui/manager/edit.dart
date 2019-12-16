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
   var _selectType;

  String statue=('請選擇');
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

Widget statueField() {
    return StreamBuilder(
        stream: _bloc.statue,
        builder: (context, AsyncSnapshot<String> snapshot) {
          int ststue=0;
          return Container(
              height: 35,
              width: MediaQuery.of(context).size.width - 140,
              decoration: BoxDecoration(
                  border:Border(bottom:BorderSide(width: 1,color: Color(0xffe5e5e5)) )
              ),
              child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    items: [
                      new DropdownMenuItem(
                        child: new Text('報名中'),
                        value: 0,
                      ),
                      new DropdownMenuItem(
                        child: new Text('活動中'),
                        value: 1,
                      ),
                      new DropdownMenuItem(
                        child: new Text('已結束'),
                        value: 2,
                      ),
                    ],
                    
                    hint: new Text(statue),
                    onChanged: (value){
                      setState(() {
                        if(value ==0){
                          _bloc.changeststue('報名中');
                          statue=('報名中');
                        }
                        else if(value == 1){
                          _bloc.changeststue('活動中');
                          statue=('活動中');
                        }
                        else{
                          _bloc.changeststue('已結束');
                          statue=('已結束');
                        }
                      });
                    },

                    value: _selectType,
                    elevation: 24,//设置阴影的高度
                    style: new TextStyle(//设置文本框里面文字的样式
                      color: Color(0xff4a4a4a),
                    ),
                  )
              )
          );
        });
  }



}
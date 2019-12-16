import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wadone_main/bloc/managerbloc.dart';
import 'package:wadone_main/bloc/pagebloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:wadone_main/ui/manager/edit.dart';
import 'package:wadone_main/ui/manager/create.dart';


class Manager extends StatefulWidget {

  Manager({Key key}) : super(key: key);
  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  Managerbloc _bloc;
  PageBloc _pageBloc;

  @override
  void didChangeDependencies() {
    _bloc = Provider.of<Managerbloc>(context);
    _pageBloc = Provider.of<PageBloc>(context);
    super.didChangeDependencies();
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
      title: Text('Manager'),
    ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
            children: <Widget>[
              Expanded(child: clubINFO()),
            ],
          ),
            actlistview()
          ],
        )
      ),
      
    );
  }

  Widget actlistview(){
    return Flexible(
      child: StreamBuilder(
        stream: _pageBloc.activeList() ,//that club's active
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snap){
          if (snap.hasData) {
                      List<DocumentSnapshot> docs = snap.data.documents;
                      List<Detail> goalsList =
                          _pageBloc.detailToList(docList: docs);
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
                detail.title,///活動名稱
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,),
              ),
              subtitle: Text('主辦單位 : '+detail.club),///社團名稱
              trailing: Text(
                detail.statue,///活動狀態
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
                      String clubid = 'nkust_IC';

                      ///fortemp this will catch that club's id(after singing)
                      _bloc.delete(clubid,detail.actid);

                      ///add to personal list
                    },
                  );
                },
              ),
            ),
            onTap: (){
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

  Widget create(){
    return RaisedButton.icon(
      onPressed: (){
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
      height: 300,
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
                      '系學會辦公地點：高科大-燕巢校區（MA305）',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '系主任：張添香',
                      style: TextStyle(fontSize: 15),
                    ),
                   Text(
                      '系會長：劉聖龍',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '系辦信箱：劉聖龍',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '電話： (07)381-4526 轉7554',
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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubClubListView extends StatelessWidget {
final String account;
String imageUrl;
SubClubListView({Key key,this.account}) : super(key:key);

Future getClub() async{
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection('subscribe').document(account).collection('subscribe_club').getDocuments();
  return  qn.documents;
} 

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width * 0.8,
      child: FutureBuilder(
        future: getClub(),
        builder: (_,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Text('Loading'),
            );
          }else{
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context,index){
                imageUrl =snapshot.data[index].data['image'];
                return ListTile(
                  title: Text(snapshot.data[index].data['c_name']),
                  leading: CircleAvatar(
                    child:ClipOval(
                      child: Image.network(imageUrl),
                    ),
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                );
              }
            );
          }
        }
      )
    );
  }
}
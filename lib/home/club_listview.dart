import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ClubListView extends StatelessWidget {
  final String category;
  ClubListView({Key key,this.category}) : super(key:key);

Future getClub() async{
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection('club').where('property',isEqualTo:category).getDocuments();
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
              String imageUrl = snapshot.data[index].data['image'];
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
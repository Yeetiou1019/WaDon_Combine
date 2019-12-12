import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ClubListView extends StatelessWidget {
  final  String category;
  final  String account;
  ClubListView({Key key ,this.category,this.account}): super(key:key);
Future getClub() async{
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection('club').where('property',isEqualTo:category).getDocuments();
  return  qn.documents;
} 

Future getSubscribe() async{
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection('subscribe').document(account).collection('subscribe_club').where('property',isEqualTo:category).getDocuments();
   //await firestore.col;ection('club').snapshots();
  return  qn.documents;
}
String cName;
String cId;
Future createSubClub() async {
  var firestore = Firestore.instance;
   await firestore.collection('subscribe')
    .document(account)
    .collection('subscribe_club')
    .document(cId)
    .setData({
        'c_name': cName,
        'property': this.category,
      });
}

void deleteSubClub() {
  try {
    var firestore = Firestore.instance;
      firestore
        .collection('subscribe')
        .document(account)
        .collection('subscribe_club')
        .document(cId)
        .delete();
  } catch (e) {
    print(e.toString());
  }
}

@override
Widget  build(BuildContext context) {
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
                  //onTap: (){},
                  trailing: 
                    SizedBox(
                      width: 40,
                      height: 40,
                      child:FutureBuilder(
                      future:getSubscribe(),
                      builder:(_,subsnapshot){          
                        if(subsnapshot.connectionState == ConnectionState.waiting){
                          return IconButton(
                              icon: Icon(Icons.rss_feed),
                              color: Colors.grey,
                              onPressed: (){
                                //createRecord();
                              },
                          );
                        }else{

                        for(var i = 0;i<snapshot.data.length;i++){
                              for(var j = 0; j<subsnapshot.data.length;j++){
                              //if(subsnapshot.data[j].data['c_name'] == snapshot.data[i].data['c_name']  ){
                                switch (subsnapshot.data[j].data['c_name'] == snapshot.data[i].data['c_name']) {
                                  case true: return IconButton(
                                  icon: Icon(Icons.rss_feed),
                                  color: Colors.blue,
                                  onPressed: (){
                                      cName = snapshot.data[i].data['c_name'];  
                                      cId = snapshot.data[i].data['c_id'];                             
                                      deleteSubClub();
                                  },
                                  highlightColor: Colors.blueGrey,
                                  disabledColor: Colors.pinkAccent,
                                );
                                  break;
                                  default:return IconButton(
                                  icon: Icon(Icons.rss_feed),
                                  color: Colors.grey,
                                  onPressed: (){
                                      cName = snapshot.data[i].data['c_name'];  
                                      cId = snapshot.data[i].data['c_id'];                             
                                      createSubClub();
                                  },
                                  highlightColor: Colors.blueGrey,
                                  disabledColor: Colors.pinkAccent,
                                );
                                }
                              }
                              break;
                            }return IconButton(
                                  icon: Icon(Icons.rss_feed),
                                  color: Colors.grey,
                                  onPressed: (){
                                      cName = snapshot.data[0].data['c_name'];  
                                      cId = snapshot.data[0].data['c_id'];                             
                                      createSubClub();
                                  },
                                  highlightColor: Colors.blueGrey,
                                  disabledColor: Colors.pinkAccent,
                                );
                            
                        // return IconButton(
                        //           icon: Icon(Icons.rss_feed),
                        //           color: Colors.grey,
                        //           onPressed: (){
                        //             if(subsnapshot.data[0].data['c_name'] == snapshot.data[0].data['c_name']){
                        //               cName = snapshot.data[0].data['c_name'];  
                        //               cId = snapshot.data[0].data['c_id'];                             
                        //               deleteSubClub();
                        //               } 
                        //               if(subsnapshot.data == null){
                        //                 cName = snapshot.data[0].data['c_name'];  
                        //                 cId = snapshot.data[0].data['c_id'];                             
                        //                 createSubClub();  
                        //               }
                        //           },
                        //           highlightColor: Colors.blueGrey,
                        //           disabledColor: Colors.pinkAccent,
                        //         );
                          //subsnapshot.data[index].data['c_name'] == snapshot.data[index].data['c_name'] 
                        }
                      }
                    ),
                  ),
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


// class ClubListView extends StatefulWidget {
//   final  String category;
//   final  String account;
//   ClubListView({this.category,this.account});

//   @override
//   _ClubListViewState createState() => _ClubListViewState();
  
// }

// class _ClubListViewState extends State<ClubListView> {

// String _category;
// String _account;

// Future getClub() async{
//   var firestore = Firestore.instance;
//   QuerySnapshot qn = await firestore.collection('club').where('property',isEqualTo:this._category).getDocuments();
//   return  qn.documents;
// } 

// Future getSubscribe() async{
//   var firestore = Firestore.instance;
//   QuerySnapshot qn = await firestore.collection('subscribe').document(this._account).collection('subscribe_club').where('property',isEqualTo:this._category).getDocuments();
//    //await firestore.col;ection('club').snapshots();
//   return  qn.documents;
// }
// String cName;
// String cId;
// Future createSubClub() async {
//   var firestore = Firestore.instance;
//    await firestore.collection('subscribe')
//     .document(this._account)
//     .collection('subscribe_club')
//     .document(cId)
//     .setData({
//         'c_name': cName,
//         'property': this._category,
//       });
// }

// void deleteSubClub() {
//   try {
//     var firestore = Firestore.instance;
//       firestore
//         .collection('subscribe')
//         .document(cName)
//         .delete();
//   } catch (e) {
//     print(e.toString());
//   }
// }
// @override
//   Widget build(BuildContext context) {
//     return Container(
//       width:MediaQuery.of(context).size.width * 0.8,
//       child: FutureBuilder(
//         future: getClub(),
//         builder: (_,snapshot){
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return Center(
//               child: Text('Loading'),
//             );
//           }else{
//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context,index){
//               String imageUrl = snapshot.data[index].data['image'];
//                 return ListTile(
//                   title: Text(snapshot.data[index].data['c_name']),
//                   trailing: 
//                     SizedBox(
//                       width: 40,
//                       height: 40,
//                       child:FutureBuilder(
//                       future:getSubscribe(),
//                       builder:(_,subsnapshot){          
//                         if(subsnapshot.connectionState == ConnectionState.waiting){
//                           return IconButton(
//                               icon: Icon(Icons.rss_feed),
//                               color: Colors.grey,
//                               onPressed: (){
//                                 //createRecord();
//                               },
//                           );
//                         }
//                         for(var i = 0;i<snapshot.data.length;i++){
//                               for(var j = 0; j<subsnapshot.data.length;j++){
//                               if(subsnapshot.data[j].data['c_name'] == snapshot.data[i].data['c_name']  ){
//                                 return IconButton(
//                                   icon: Icon(Icons.rss_feed),
//                                   color: Colors.blue,
//                                   onPressed: (){
//                                       cName = snapshot.data[i].data['c_name'];  
//                                       cId = snapshot.data[i].data['c_id'];                             
//                                       deleteSubClub();
//                                   },
//                                   highlightColor: Colors.blueGrey,
//                                   disabledColor: Colors.pinkAccent,
//                                 );
//                               }
//                             }break;
//                         }return IconButton(
//                                   icon: Icon(Icons.rss_feed),
//                                   color: Colors.grey,
//                                   onPressed: (){
//                                     cName = snapshot.data[0].data['c_name'];
//                                     cId = snapshot.data[0].data['c_id'];
//                                     createSubClub();
//                                     setState(() {
                                     
//                                     });
//                                   },
//                                   highlightColor: Colors.blueGrey,
//                                   disabledColor: Colors.pinkAccent,
//                                 );  
//                           //subsnapshot.data[index].data['c_name'] == snapshot.data[index].data['c_name'] 
//                       }
//                     ),
//                   ),
//                   leading: CircleAvatar(
//                     child:ClipOval(
//                       child: Image.network(imageUrl),
//                     ),
//                     backgroundImage: NetworkImage(imageUrl),
//                   ),
                  
//                 );
//               }
//             );
//           }
//         }
//       )
//     );
//   }
// }

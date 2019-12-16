import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:wadone_main/firebase/firestore/user_picture/upload_picture.dart';
import './sub_club_listview.dart';
import './club_listview.dart';
import '../firebase/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String accountImage;
class SlideDrawer extends StatelessWidget {
  final String account;
  final _firestore = Firestore.instance;
  SlideDrawer({Key key,this.account}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child:Drawer(
          child: ListView(
            children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(account), 
              accountName: FutureBuilder<String>(
                future: getUserName(account),  
                builder: (context,snapshot){
                  switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                        case ConnectionState.done:
                          if (snapshot.data == null || snapshot.data == ''){
                            return Text('快去個人頁面設定名字！');
                            }else {
                            return Text(snapshot.data);
                          }
                      }
                  return null;
                },
              ),
              currentAccountPicture:FutureBuilder<String>(
                  future: getProfilePictureUrl(account),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                          break;
                        case ConnectionState.done:
                          if (snapshot.data == null || snapshot.data == ''){
                            return CircleAvatar(
                              backgroundImage: AssetImage('assets/dog_akitainu.png'),
                            );
                            }else {
                            return CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data),
                           );
                          }
                      }
                      return null;
                    },
                  ),
            ),
            // ListTile(
            //   leading: Icon(Icons.file_upload),
            //   title: Text('Profile picture'),
            //   onTap: () async {
            //     File image =
            //         await ImagePicker.pickImage(source: ImageSource.gallery);
            //     if (image != null) {
            //       var uploadTask = uploadImage(image, account);
            //       await uploadTask.onComplete;
            //       String url = await uploadTask.lastSnapshot.ref.getDownloadURL();
            //       updateProfilePictureUrl(account, url);
            //     }
            //   },
            // ),
        //     ExpansionTile(  //可展開列表
        //       title: Text('已訂閱社團'),
        //       children: <Widget>[ //子列表
        //         SubClubListView(account: account,),
        //       ],
        // //subtitle: Text('ListSubtitle1',maxLines: 2,overflow: TextOverflow.ellipsis,),
        //     leading: CircleAvatar(child: Text("訂")),
        //     ),
            ExpansionTile(
              title: Text('服務性社團'),
              children: <Widget>[
                ClubListView(category: '服務性',account: account,),
              ],
        //subtitle: Text('ListSubtitle1',maxLines: 2,overflow: TextOverflow.ellipsis,),
            leading: CircleAvatar(child: Text("服")),
            ),
            ExpansionTile(
              title: Text('學術性社團'),
              children: <Widget>[
                ClubListView(category: '學',account: account,),
              ],
        //subtitle: Text('ListSubtitle2',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: CircleAvatar(child: Text("學")),
            ),
            ExpansionTile(
              title: Text('康樂性社團'),
              children: <Widget>[
                ClubListView(category: '康樂性',account: account),
              ],
              //subtitle: Text('ListSubtitle3',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: CircleAvatar(child: Text("康")),
            ),
            ExpansionTile(
              title: Text('體育性社團'),
              children: <Widget>[
                ClubListView(category: '體育性',account: account),
              ],
              //subtitle: Text('ListSubtitle3',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: CircleAvatar(child: Text("體"),),
            ),
            ExpansionTile(
              title: Text('系學會'),
              children: <Widget>[
                ClubListView(category: '系學會',account: account),
              ],
              //subtitle: Text('ListSubtitle3',maxLines: 2,overflow: TextOverflow.ellipsis,),
              leading: CircleAvatar(child: Text("系")),
            ),
          Divider(),//分割線
          new AboutListTile(
            icon: new CircleAvatar(),
            child: new Text("關於WaDone"),
            applicationName: "WaDone",
            applicationVersion: "1.0",
            applicationLegalese: "NKUST IC",
            aboutBoxChildren: <Widget>[
              new Text("文字"),
              new Text("文字")
            ],
          ),
          Divider(),//分割線
        ],
       ),
      ),
    );
  }
   
}
final _firestore = Firestore.instance;
              
              Future<Map> getusername(account) async {

    DocumentSnapshot doc = await _firestore.collection('users').document(account).get();
    Map<String,String> name =  doc.data['name'];

    return name;
    }
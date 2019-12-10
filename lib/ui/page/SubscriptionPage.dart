import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wadone_main/ui/club/clubpage.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  getdata() {}  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: Firestore.instance.collection('club').snapshots(),
      builder: (context, snap) {
        if (snap.hasData) {
          List<DocumentSnapshot> dsList = snap.data.documents;
          return ListView.builder(
              itemCount: dsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = dsList[index];
                return Container(
                  child: ExpansionTile(
                    title: Text('全部社團'),
                    initiallyExpanded: true,
                    children: <Widget>[
                      ListTile(
                        title: Text(doc['c_name']),
                        subtitle: Text(doc['c_type']),
                        onTap: () {
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Clubpage(),
                              ),
                            );
                          }
                          setState(() {});
                        },
                        leading: CircleAvatar(child: Text(doc['c_leading'])),
                      ),
                    ],
                    leading: CircleAvatar(child: Text("全")),
                  ),
                );
              });
        }
        return Container(
          child: Text('載入錯誤'),
        );
      },
    ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:algolia/algolia.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key key}) : super(key:key);
  @override
  _SearchFieldState createState() => _SearchFieldState();
}


class _SearchFieldState extends State<SearchField> {

  TextEditingController _searchText = TextEditingController(text: "");

  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;

  _search() async {
    setState(() {
      _searching = true;
    });

    Algolia algolia = Algolia.init(
      applicationId: 'SJAWWWHOCC',
      apiKey: '7dfa311b08141f9e1ab7168173483641',
    );

    AlgoliaQuery query = algolia.instance.index('wadon_dev');
    query = query.search(_searchText.text);

    _results = (await query.getObjects()).hits;

    setState(() {
      _searching = false;
    });
  }
    Future getClub() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('club').getDocuments();
    return  qn.documents;
  } 

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 500,
            child:TextField(
              
              controller: _searchText,
              decoration: InputDecoration(hintText: "標題、社團..."),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  child: Text(
                    "搜尋",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _search,
                ),
              ],
            ),
            Expanded(
              child: _searching == true
                  ? Center(
                      child: Text("正在搜尋中..."),
                    )
                  : _results.length == 0 || _results.length == null 
                      ? Center(
                          child: Text("無符合資料"),
                        )
                      : ListView.builder(
                          itemCount: _results.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            AlgoliaObjectSnapshot snap = _results[index];
                            return FutureBuilder(
                              future: getClub(),
                              builder: (_,snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(
                                    child: Text('Loading'),
                                  );
                                }else{
                                  for(var i = 0;i<=index;i++){
                                    if(snapshot.data[i].data['c_name'] == _results[index].data['club_id']){
                                      String imageUrl = snapshot.data[i].data['image'];
                                      break;
                                    }
                                  }
                                  return ListTile(
                                    title: Text(snap.data["p_title"]),
                                    subtitle:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Text(snap.data["p_name"]), Text(snap.data["club_id"])]
                                      ),
                                    );
                                }
                              }
                            );
                          },
                        ),
            ),
          ],
        ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
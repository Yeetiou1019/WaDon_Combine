import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wadone_main/models/active.dart';
import 'package:wadone_main/models/detail.dart';
import 'package:wadone_main/firebase/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class PageBloc with ChangeNotifier {
  Firestore _firestore = Firestore.instance;
  final _repository = Repository();
  final _activeId = BehaviorSubject<String>();
  final _clubId = BehaviorSubject<String>();

  Function(String) get thisactiveId => _activeId.sink.add;
  Function(String) get clubId => _clubId.sink.add;
///that club's all active
  Stream<QuerySnapshot> activeList() {
    return _repository.pageList();
  }

  ///act detail
  Stream<QuerySnapshot> allact() {
    return _repository.actList(_clubId.value,_activeId.value);
  }
///all act
  Stream<QuerySnapshot> allActList() {
    return _repository.pageList();
  }

//dispose open sink
  void dispose() async {
    await _activeId.drain();
    _activeId.close();
    await _clubId.drain();
    _clubId.close();
  }

  List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if (docList != null) {
      List<Active> activeList = [];
      docList.forEach((document) {
        String club = document.data['c_id'];
        Map<String, String> active = document.data['posts'] != null
            ? document.data['posts'].cast<String, String>()
            : null;
        if (active != null) {
          active.forEach((title, description) {
            Active active = Active(club, title, description);
            activeList.add(active);
          });
        }
      });
      return activeList;
    }
  }

  List detailToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
    if(docList != null){
      List<Detail> detaillist=[];
      docList.forEach((document){

        String actid =document.data['p_id'];
        String club=document.data['club_id'];
        String description=document.data['p_content'];
        String title=document.data['p_title'];
        String pname=document.data['p_name'];
        String statue = document.data['statue'];
        String numlimit = document.data['num_limit'];
        String clublimit = document.data['club_limit'];
        String localtion = document.data['p_localtion'];
        String note = document.data['p_note'];



        Detail data =Detail(actid,club,title,description,pname,statue,numlimit,clublimit,localtion,note);
        detaillist.add(data);
      });
      return detaillist;
    }
    else{
      return null;
    }
  }

  void remove(String thatclubid) {
    _repository.clubListDelete(_activeId.value,thatclubid);
    _repository.deletePosts(_activeId.value,thatclubid);
    // _repository.deleteFromUserActlist(); (unready to do)
  }

  
  // bool judgeUserInActive(){
  //   for(final i in userlist){
  //     print('$i');
  //     if (i == 2){
  //       return true;
  //       }
  //       }
  //       }
}
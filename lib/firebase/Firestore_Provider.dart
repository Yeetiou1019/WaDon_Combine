import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  ///home page stream
  Stream<QuerySnapshot> pageList() {
    return _firestore
        .collection("posts")
        .document('nkust_IC')///find out something can fetch all club
        .collection('club_post')
        .snapshots();
  }

  ///that club's all active
  Stream<QuerySnapshot> actList(String clubid,String actid){
     return _firestore
     .collection("posts")
     .document(clubid)
     .collection('club_post')
     .where('p_id',isEqualTo: actid )
     .snapshots();
  }
  
  Future<void> clubadd(String actid,String clubid){
    return _firestore
    .collection('club')
    .document(clubid)
    .collection('club_posts')
    .document(actid)
    .setData({
      'c_id':clubid,
      'p_id':actid,
      'posts':{
        'key{'+actid+'}':actid}
    });
  }

  Future<void> join(String documentId,num idcount,String user ){
    return _firestore
    .collection('post')
    .document(documentId)
    .setData({
      'id':idcount+1,
      'userList':user,
    });
  }

  Future<void> userjoin(String actid,String userid){
    return _firestore
    .collection('user')
    .document(userid)
    .setData({
      'actlist':actid
    });
  }
///END ACT DO something

Future<void> changeStatue(String actid,String statue){
  return _firestore
  .collection('posts')
  .document(actid)
  .updateData({'statue':statue});
}

Future<void> uploadAct(String clubid,String name,String title,String content,String clublimit,String numlimit,String actid,String statue,String localtion, String note){
  return _firestore
  .collection('posts')
  .document(clubid)
  .collection('club_post')
  .document(actid)
  .setData({
    'p_id':actid,
    'club_id':clubid,
    'p_content':content,
    'p_name':name,
    'p_title':title,
    'num_limit':numlimit,
    'club_limit':clublimit,
    'statue':statue,
    'p_localtion':localtion,
    'p_note':note
    ///10
  });
}


 Future<void> clubListDelete(String activeId, String thatclubid)async {
  await _firestore
   .collection('club')
   .document(thatclubid)
   .collection('club_posts')
   .document(activeId)
   .delete();
 }

 Future<void> deletePosts(String activeId, String thatclubid) async{
  await _firestore
   .collection('posts')
   .document(thatclubid)
   .collection('club_post')
   .document(activeId)
   .delete();
 }

 Future<void> edit(String thatclubid,String activeId,String ptitle, String pcontent, String clublimit, String numlimit, String plocaltion, String pnote,String statue ,String name) async{
  await  _firestore
    .collection('posts')
    .document(thatclubid)
    .collection('club_post')
    .document(activeId)
    .updateData({
      'p_id':activeId,
      'club_id':thatclubid,
      'p_name':name,
      'statue':statue,
      'p_title':ptitle,
      'p_content':pcontent,
      'club_limit':clublimit,
      'num_limit':numlimit,
      'p_localtion':plocaltion,
      'p_note':pnote,
    });
  }
  


}
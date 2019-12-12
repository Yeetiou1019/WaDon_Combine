import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './Firestore_Provider.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  Firestore _firestore = Firestore.instance;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  
  Future<void> addUserToFirestore(String email,String password,String cId,String gender,String tel,String name,String student) async {
    return _firestore
        .collection("users")
        .document(email)
        .setData({'email': email, 'club': cId,'gender':gender,'tel':tel,'name':name,'student':student,});
  }


  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}

Future<String> getUserName(String account) async {
// 用使用者信箱當作索引值去找到對應的文件
  var doc = await Firestore.instance.collection('users').document(account).get();
  if (doc.exists) {
    return doc.data['u_name'];
  }
  return '';
}

Future<String> getProfilePictureUrl(String account) async {
// 用使用者信箱當作索引值去找到對應的文件
  var doc = await Firestore.instance.collection('users').document(account).get();
  if (doc.exists) {
    return doc.data['user_picture'];
  }
  return '';
}

void updateProfilePictureUrl(String account, String url) async {
// 用使用者信箱當作索引值去新增or更新 圖片路徑
    await Firestore.instance.collection("users").document(account).setData({
      'user_picture': url,
    });
}

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Stream<QuerySnapshot> pageList() => _firestoreProvider.pageList();

  Stream<QuerySnapshot> actList(String clubid,String actid) => _firestoreProvider.actList(clubid,actid) ;

  Future<void> clubadd(String actid,String clubid) =>_firestoreProvider.clubadd(actid,clubid);

  Future<void> changeStatue(String actid,String statue)=> _firestoreProvider.changeStatue(actid, statue);

  Future<void> uploadAct(String clubid,String name,String title,String content,String clublimit,String numlimit,String actid,String statue,String localtion, String note) =>
   _firestoreProvider.uploadAct(clubid,name,title,content,clublimit,numlimit,actid,statue,localtion,note);

  Future<void> clubListDelete(String activeId, String thatclubid) => _firestoreProvider.clubListDelete(activeId,thatclubid);

  Future<void> deletePosts(String activeId, String thatclubid) => _firestoreProvider.deletePosts(activeId,thatclubid);

  Future<void> edit(String thatclubid,String activeId,String ptitle, String pcontent, String clublimit, String numlimit, String plocaltion, String pnote,String statue,String name) =>
  _firestoreProvider.edit(thatclubid,activeId,ptitle,pcontent,clublimit,numlimit,plocaltion,pnote,statue,name);

  Stream<DocumentSnapshot> getUserData(String account) => _firestoreProvider.getUserData(account);

  Stream<QuerySnapshot> subscribeList(String account) =>_firestoreProvider.subscribeList(account);

  Stream<QuerySnapshot> clubpost(String clubid) => _firestoreProvider.clubpost(clubid);

  Stream<QuerySnapshot> userJoinList(String account) => _firestoreProvider.userJoinList(account);
}
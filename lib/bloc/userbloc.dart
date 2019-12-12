import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wadone_main/firebase/Firestore_Provider.dart';
import 'package:wadone_main/firebase/user_repository.dart';

class Userbloc {
  final _repository = Repository();
  final _firestore = Firestore.instance;
  final _userName = BehaviorSubject<String>();
  final _account = BehaviorSubject<String>();

  Observable<String> get username => _userName.stream;
  Observable<String> get account => _account.stream;

  Function(String) get changeusername => _userName.sink.add;
  Function(String) get changeaccount => _account.sink.add;

  Stream<DocumentSnapshot> getUserData() {
    return _repository.getUserData(_account.value);
  }

  Stream<QuerySnapshot> clubpost(String clubid) {
    return _repository.clubpost(clubid);
  }

  void dispose() async {
    await _userName.drain();
    _userName.close();
    await _account.drain();
    _account.close();
  }

  
}
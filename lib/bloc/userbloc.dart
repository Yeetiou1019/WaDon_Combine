import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wadone_main/firebase/Firestore_Provider.dart';
import 'package:wadone_main/firebase/user_repository.dart';

class Userbloc {
  final _repository = Repository();
  final _firestore = Firestore.instance;
  final _userName = BehaviorSubject<String>();
  final _account = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _property = BehaviorSubject<bool>();

  Observable<String> get username => _userName.stream;
  Observable<String> get account => _account.stream;
  Observable<String> get name => _name.stream;
  Observable<bool> get property => _property.stream;

  Function(String) get changeusername => _userName.sink.add;
  Function(String) get changeaccount => _account.sink.add;
  Function(String) get changename => _name.sink.add;
  Function(bool) get changeproperty =>_property.sink.add;
  

  Stream<DocumentSnapshot> getUserData() {
    return _repository.getUserData(_account.value);
  }

  Stream<QuerySnapshot> clubpost(String clubid) {
    return _repository.clubpost(clubid);
  }

  bool judge(bool property){
    if(property == true){
      return true;
    }
    else{
      return false;
    }
  }
  //   bool judge(bool property){
  //     return property == true ? property : false;
  // }

  void dispose() async {
    await _userName.drain();
    _userName.close();
    await _account.drain();
    _account.close();
    await _name.drain();
    _name.close();
    await _property.drain();
    _property.close();
  }

  
}
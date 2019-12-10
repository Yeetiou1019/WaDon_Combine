import 'package:cloud_firestore/cloud_firestore.dart';
class Detail {
  final String _actid;
  final String _title;
  final String _description;
  final String _club;
  final String _pname;
  final String _statue;
  final String _numlimit;
  final String _clublimit;
  final String _localtion;
  final String _note;
  int _id;

  Detail(
    this._actid,
    this._club,
    this._title,
    this._description,
    this._pname,
    this._statue,
    this._numlimit,
    this._clublimit,
    this._localtion,
    this._note
    ){
    this._id = DateTime.now().millisecondsSinceEpoch;
  }

  String get title => _title;
  String get statue => _statue;
  String get actid => _actid;
  String get description => _description;
  String get club => _club;
  String get pname => _pname;
  String get numlimit =>_numlimit;
  String get clublimit =>_clublimit;
  String get localtion =>_localtion;
  String get note =>_note;
  int get id => _id;

}
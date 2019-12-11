import 'dart:ui';

class Club {
  final String _name;
  final String _id;
  final String _pic;

  Club(
    this._id,
    this._name,
    this._pic
  );

  String get name => _name;
  String get id =>_id;
  String get pic =>_pic;

}
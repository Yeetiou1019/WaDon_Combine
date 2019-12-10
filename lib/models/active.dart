class Active {
  final String _title;
  final String _description;
  final String _club;
  int _id;

  Active(this._club,this._title, this._description,){
    this._id = DateTime.now().millisecondsSinceEpoch;
  }

  String get title => _title;
  String get description => _description;
  String get club => _club;
  int get id => _id;

}
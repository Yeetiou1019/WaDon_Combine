class Active {
  final String _actid;
  final String _name;
  final String _title;
  final String _description;
  final String _club;
  final String _palce;
  final String _note;
  final String _content;
  final String _statue;
  int _id;

  Active(this._actid,this._name,this._club,this._title, this._description,this._note,this._palce,this._content,this._statue){
    this._id = DateTime.now().millisecondsSinceEpoch;
  }

  String get actid => _actid;
  String get name =>_name;
  String get title => _title;
  String get description => _description;
  String get club => _club;
  String get note => _note;
  String get place => _palce;
  String get content => _content;
  String get statue => _statue;
  int get id => _id;

}
class Apppointo {
  int _id;
  String _name;
  String _date;

  Apppointo(this._name, this._date);

  Apppointo.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._date = obj['date'];
  }

  int get id => _id;
  String get name => _name;
  String get date => _date;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['date'] = _date;

    return map;
  }

  Apppointo.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._date = map['date'];
  }
}

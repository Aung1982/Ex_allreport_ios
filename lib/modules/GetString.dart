class GetString {
  //AID,
  String _shop;
  String _typeOfSoft;
  String _dt;
  String _tm;
   String _srlist;
   String _shplist;
  GetString(this._shop, this._typeOfSoft, this._dt, this._tm, this._srlist, this._shplist);

  GetString.WithId(this._shop, this._typeOfSoft, this._dt, this._tm, this._srlist, this._shplist);

  String get shop => _shop;
  String get typeOfSoft => _typeOfSoft;
  String get dt => _dt;
  String get tm => _tm;
  String get srlist => _srlist;
    String get shplist => _shplist;

  set shop(String newshop) {
    _shop = newshop;
  }

  set typeOfSoft(String newtypeOfSoft) {
    _typeOfSoft = newtypeOfSoft;
  }

  set dt(String newdt) {
    _dt = newdt;
  }

  set tm(String newtm) {
    _tm = newtm;
  }

 set srlist(String newsrlist) {
    _srlist = newsrlist;
  }
 set shplist(String newshplist) {
    _shplist = newshplist;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //AID,E_ID,E_Name,T_1,T_2,T_3,T_4,T_5,T_6,pT_1,pT_2,pT_3,pT_4,pT_5,pT_6,SaveDate,SaveTime
    map["Shop"] = _shop;
    map["TypeOfSoft"] = _typeOfSoft;
    map["dt"] = _dt;
    map["tm"] = _tm;
    map["srlist"] = _srlist;
    map["shpname"] = _shplist;
    return map;
  }

  GetString.fromObject(dynamic o) {
    this.shop = o["shop"];
    this.typeOfSoft = o["typeOfSoft"];
    this.dt = o["dt"];
    this.tm = o["tm"];
     this.srlist = o["srlist"];
      this.shplist = o["shpname"];
  }
}

/*
class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String releaseDate;
  final String description;
  final int totalCopies;
  final int availableCopies;

  /// Creates a Book instance out of JSON received from the API.
  Book.fromJson(Map<String, dynamic> json)
      : id = json['aid'],
        title = json['item_ID'],
        releaseDate = json['item_Name'],
        description = json['quantity'],
        totalCopies = json['sellPrc1'],
        availableCopies = json['sellPrc2'],
        authors = json['station'].retype<String>();
} */

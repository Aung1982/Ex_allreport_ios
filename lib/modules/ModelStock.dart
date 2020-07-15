class ModelStock {
  //AID,    TOP (200) Item_ID, Item_Name, Item_Type, Quantity, Reorder, SellPrc1, SellPrc2, TotalStock, Station, TQtyPacking, DC1, DC2, V3_Unit, Unit, MultiUser, AID
//FROM            Purchase
  int _aID;
  String _itemID;
  String _itemName;
  double _quantity;
  double _sellPrc1;
  double _sellPrc2;
  String _station;
  String _date;
  String _vid;
String _catg;

  ModelStock(this._aID, this._itemID, this._itemName, this._quantity,
      this._sellPrc1, this._sellPrc2, this._station, this._date, this._vid,this._catg);
  // this._shop,
  // this._typeOfSoft);

  ModelStock.WithId(this._aID, this._itemID, this._itemName, this._quantity,
      this._sellPrc1, this._sellPrc2, this._station, this._date, this._vid,this._catg);

  int get aID => _aID;
  String get itemID => _itemID;
  String get itemName => _itemName;
  double get quantity => _quantity;
  double get sellPrc1 => _sellPrc1;
  double get sellPrc2 => _sellPrc2;
  String get station => _station;
  String get date => _date;
  String get vid => _vid;
 String get catg => _catg;

  set aID(int newaID) {
    _aID = newaID;
  }

  set itemID(String newitemID) {
    _itemID = newitemID;
  }

  set itemName(String newitemName) {
    _itemName = newitemName;
  }

  set quantity(double newquantity) {
    _quantity = newquantity;
  }

  set sellPrc1(double newsellPrc1) {
    _sellPrc1 = newsellPrc1;
  }

  set sellPrc2(double newsellPrc2) {
    _sellPrc2 = newsellPrc2;
  }

  set station(String newstation) {
    _station = newstation;
  }

  set date(String newdate) {
    _date = newdate;
  }

  set vid(String newvid) {
    _vid = newvid;
  }

  set catg(String newvcatg) {
    _catg = newvcatg;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //AID,    TOP (200) Item_ID, Item_Name, Item_Type, Quantity, Reorder, SellPrc1, SellPrc2, TotalStock, Station, TQtyPacking, DC1, DC2, V3_Unit, Unit, MultiUser, AID
//FROM            Purchase
    map["aid"] = aID;
    map["item_ID"] = itemID;
    map["item_Name"] = itemName;
    map["quantity"] = quantity;
    map["sellPrc1"] = sellPrc1;
    map["sellPrc2"] = sellPrc2;
    map["station"] = station;
    map["date"] = date;
    map["vid"] = vid;
     map["catg"] = catg;
    return map;
  }

  ModelStock.fromObject(dynamic o) {
    this.aID = o["aid"];
    this.itemID = o["item_ID"];
    this.itemName = o["item_Name"];
    this.quantity = o["quantity"];
    this.sellPrc1 = o["sellPrc1"];
    this.sellPrc2 = o["sellPrc2"];
    this.station = o["station"];
    this.date = o["date"];
    this.vid = o["vid"];
    this.catg = o["catg"];
  }
}

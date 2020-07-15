import 'dart:async';

import 'package:flutter/material.dart';
import 'package:excellent_all_pos_report/modules/api.services.dart';
import 'dart:convert';
import 'package:excellent_all_pos_report/modules/ModelStock.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:excellent_all_pos_report/modules/global.dart' as globals;

class FrmStockRpt extends StatefulWidget {
  @override
  _FrmStockRptState createState() => _FrmStockRptState();
}

class _FrmStockRptState extends State<FrmStockRpt> {
  List<ModelStock> lpd;
  //List<ModelStock> tempList;
  bool fitstLoad = false;
  bool findLoad = false;
      String czfont = globals.zfonts;
   
  //String sval = "One";
  //String dropdownValue = 'One';
  final TextEditingController txtFindBy = new TextEditingController();
  final TextEditingController txtData = new TextEditingController();
  final currencyFormatter = NumberFormat("###,###,###,###,##0.00", 'en_US');

  // List<String> dogsBreedList = List<String>();
//  List<String> tempList = List<String>();
  // List<DetailsStock> dStock;
  @override
  Widget build(BuildContext context) {
    if (globals.srnoforshop == "" ) {
      Fluttertoast.showToast(
          msg: "Please select your shop name!",
          backgroundColor: Colors.black,
          textColor: Colors.white);
          Timer(Duration(seconds: 3), () => Navigator.pop(context));
    }
 if (globals.unicodestatus == true ) czfont = globals.ufonts;
    getAuthentication();
    
    return Scaffold(
      
        appBar: AppBar(
          actions: <Widget>[
            // _searchBar(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _showDialog();
              },
            ),
          ],
          title: Text('STOCK LIST'),
          
        ),
        body: bodyLoad(),
        
        );
  }

  Widget bodyLoad() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: lpd == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text("Loading....",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  : lpd.length == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text("Loading....",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      : ListView.builder(
                          itemCount: lpd.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3.0,
                              child: InkWell(
                                onTap: () //{
                                    {},
                                child: ListTile(
                                                            title: Text((index + 1).toString() +
                                      ". " +
                                      lpd[index].itemID, style:  TextStyle(fontFamily:  czfont),),
                                  subtitle:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      
                                      Text(
                                        lpd[index].itemName,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500, fontFamily:  czfont),
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          //Text('Qty: '),${product.productName}
                                          Text(
                                            "Qty:${currencyFormatter.format(lpd[index].quantity).toString()}",
                                            style:
                                                TextStyle(color: Colors.red),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                          ),
                                          Text(
                                            "Price I:  ${currencyFormatter.format(lpd[index].sellPrc1).toString()}",
                                            style:
                                                TextStyle(color: Colors.red),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Price II:  ${currencyFormatter.format(lpd[index].sellPrc2).toString()}",
                                            style:
                                                TextStyle(color: Colors.red),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                          ),
                                          Text(lpd[index].station,style:  TextStyle( fontFamily:  czfont),)
                                        ],
                                      )
                                    ],
                                  ),
                                  /* trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: null,
                          ), */
                                ),
                              ),
                            );
                          })),
        ],
      ),
    );
  }

//N'" + globals.register_pref + "'")
  void getAuthentication() async {
    if (fitstLoad == false) {
      APIServices.getUser("http://" +
              globals.apipref +
              ":" +
              globals.portpref +
              "/AllPos/AllPosRpt/Get_Stock/" +
              globals.srnoforshop + "/" +   globals.unicodestatus.toString())
          .then((reponse) {
        Iterable list = json.decode(reponse.body);
        List<ModelStock> userList = List<ModelStock>();
        userList = list.map((model) => ModelStock.fromObject(model)).toList();
        int count = userList.length;
        if (count != 0) {
          setState(() {
            lpd = userList;
            fitstLoad = true;
            // tempList = lpd;
          });
        }
      });
    }
  }

  void getAuthenticationFind(String val) async {
    if (findLoad == false) {
      APIServices.getUser("http://" +
              globals.apipref +
              ":" +
              globals.portpref +
              "/AllPos/AllPosRpt/Get_Stock/" +
              globals.srnoforshop +
              val + "/" +   globals.unicodestatus.toString())
          .then((reponse) {
        Iterable list = json.decode(reponse.body);
        List<ModelStock> userList = List<ModelStock>();
        userList = list.map((model) => ModelStock.fromObject(model)).toList();
        int count = userList.length;
        if (count != 0) {
          setState(() {
            lpd = userList;
            findLoad = true;
            // tempList = lpd;
          });
        }
      });
    }
  }

  final List<String> _dropdownValues = ["Item ID", "Item Name", "Store"];
  
  _showDialog() async {
    txtFindBy.text = "Item ID";
    // loadGenderList();
    await showDialog<String>(
      context: context,
      child: Container(
        //  padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 0.0, vertical: 100.0),
        //height: 20.0,
        //width: 100.0,
        // height: 56.0,
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  DropdownButton(
                    // value: "Test",
                    items: _dropdownValues
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (String value) {
                      txtFindBy.text = value;
                      //sval = value;
                    },
                    //value: sval,
                    isExpanded: false,
                    hint: Text('Search By:'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: new TextField(
                      controller: txtFindBy,
                      enabled: false,
                    ),
                  )
                ],
              ),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: new TextField(
                      autofocus: true,
                      controller: txtData,
                      decoration: new InputDecoration(
                          labelText: 'Search Here', hintText: 'eg. ID00012'),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('FIND'),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    // bodyLoad("' and Item_ID Like N'" + txtData.text + "%");
                    _searchData();
                  });
                })
          ],
        ),
      ),
    );
  }

  void _searchData() {
    findLoad = false;
    lpd.clear();
    // bodyLoad();
    //lpd == null;
    String dta = txtData.text;
    if (dta != "") {
      //["Item ID", "Item Name", "Store"];
      String clm_Data = txtFindBy.text;
      String clm = "Item_ID";

      switch (clm_Data) {
        case "Item Name":
          {
            clm = "Item_Name";
          }
          break;

        case "Store":
          {
            clm = "Station";
          }
          break;
      }
      String sql = "' and " + clm + " Like N'" + txtData.text + "%";
      getAuthenticationFind(sql);
    } else {
      Fluttertoast.showToast(
          msg: "Fill search data!",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }
}

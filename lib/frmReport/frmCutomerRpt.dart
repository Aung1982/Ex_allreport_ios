import 'dart:async';

import 'package:flutter/material.dart';
import 'package:excellent_all_pos_report/modules/api.services.dart';
import 'dart:convert';
import 'package:excellent_all_pos_report/modules/ModelStock.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:excellent_all_pos_report/modules/global.dart' as globals;

//import 'package:excellent_all_pos_report/frmReport/detailsStock.dart';

class FrmCutomerRpt extends StatefulWidget {
  @override
  _FrmCutomerRptState createState() => _FrmCutomerRptState();
}

class _FrmCutomerRptState extends State<FrmCutomerRpt> {
  List<ModelStock> lpd;
String czfont = globals.zfonts;
  bool fitstLoad = false;
  bool findLoad = false;
  final TextEditingController txtFindBy = new TextEditingController();
  final TextEditingController txtData = new TextEditingController();
 final currencyFormatter = NumberFormat("###,###,###,###,##0.00", 'en_US');
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
          title: Text('CUSTOMER CREDIT'),
        ),
        body: bodyLoad());
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
                            if (lpd[index].itemID.toString() == "TOTAL") {
                              return unnormaldata(index, lpd[index].itemID,
                                  lpd[index].quantity, lpd[index].station);
                            }
                            {
                               return normaldata(
                                  index,
                                  lpd[index].itemID,
                                  lpd[index].itemName,
                                  lpd[index].quantity,
                                  lpd[index].station);
                             
                            }
                          })),
        ],
      ),
    );
  }

  Widget normaldata(
      int idx, String itID, String itName, double qty, String station) {
    return Card(
      elevation: 3.0,
      child: InkWell(
        onTap: () //{
            {},
        child: ListTile(
          isThreeLine: true,
          title: Text(
            (idx + 1).toString() + ". " + itID.toString(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontFamily:  czfont),
          ),
          subtitle: Column(
            children: <Widget>[
               Text(
                 itName,
                 style:
                     TextStyle(color: Colors.red, fontWeight: FontWeight.w500,fontFamily:  czfont),
                     //maxLines: 3,
               ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Amount:",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
               
                 Container(
                                     alignment: Alignment.centerRight,
                    child: Text(
                      "${currencyFormatter.format(qty).toString()}",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                      textAlign: TextAlign.end,
                    ),
                  ), 
                   ], 
              ),
              /*Row(
                children: <Widget>[
                  Text(
                    "Amount: ${currencyFormatter.format(qty).toString()}",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),*/
              Row(
                children: <Widget>[
                  Text("Ph. No. " + station,
                      style: TextStyle(color: Colors.blue,fontFamily:  czfont))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget unnormaldata(int idx, String itID, double qty, String station) {
    return Card(
      elevation: 3.0,
      child: InkWell(
        onTap: () //{
            {},
        child: ListTile(
          //isThreeLine: true,
          subtitle: Column(
            children: <Widget>[
              /*Text(
                (idx + 1).toString() + ". " + itID.toString(),
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
              ),*/
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    (idx + 1).toString() + ". " + itID.toString(),
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
               
                 Container(
                                     alignment: Alignment.centerRight,
                    child: Text(
                      "${currencyFormatter.format(qty).toString()}",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                      textAlign: TextAlign.end,
                    ),
                  ), 
                   ], 
              ),
              /*
              Text(
                "${currencyFormatter.format(qty).toString()}",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 14.0),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  void getAuthentication() async {
    if (fitstLoad == false) {
      APIServices.getUser(
              "http://" + globals.apipref + ":" + globals.portpref + "/AllPos/AllPosRpt/Get_Credit/Where MultiUser = N'" + globals.srnoforshop + "'/" +  globals.unicodestatus.toString())
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
      APIServices.getUser(
              "http://" + globals.apipref + ":" + globals.portpref + "/AllPos/AllPosRpt/Get_Credit/Where MultiUser = N'" + globals.srnoforshop + "'" +
                  val + "/"  +  globals.unicodestatus.toString())
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

  final List<String> _dropdownValues = ["Customer", "Address", "Ph. No."];
  _showDialog() async {
    txtFindBy.text = "Customer";
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
                          labelText: 'Search Here', hintText: 'eg. U Mg Mg'),
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
      //SELECT        TOP (200) AID, CName, CAddress, CPh, CAmt,, MultiUser FROM TblCustomerData
      String clm_Data = txtFindBy.text;
      String clm = "CName";

      switch (clm_Data) {
        case "Address":
          {
            clm = "CAddress";
          }
          break;

        case "Ph. No.":
          {
            clm = "CPh";
          }
          break;
      }
      //Where MultiUser = N'XxK3kk83' and " +'

      String sql = " and " + clm + " Like N'" + txtData.text + "%'";
      getAuthenticationFind(sql);
    } else {
      Fluttertoast.showToast(
          msg: "Fill search data!",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }
}

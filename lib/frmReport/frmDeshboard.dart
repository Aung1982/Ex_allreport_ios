import 'dart:convert';
import 'dart:io';
import 'package:excellent_all_pos_report/modules/GetString.dart';
import 'package:excellent_all_pos_report/modules/api.services.dart';
import 'package:flutter/material.dart';
import 'package:excellent_all_pos_report/modules/global.dart' as globals;
import 'package:excellent_all_pos_report/frmReport/frmStockRpt.dart';
import 'package:excellent_all_pos_report/frmReport/frmSaleRpt.dart';
import 'package:excellent_all_pos_report/frmReport/frmCutomerRpt.dart';
import 'package:excellent_all_pos_report/frmReport/frmSupplierRpt.dart';
import 'package:excellent_all_pos_report/frmReport/frmBalanceRpt.dart';
//import 'package:toggle_switch/toggle_switch.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//void main() => runApp(MaterialApp(
//      home: Report(),
//  ));
/*
class Item {
  const Item(this.sname,this.srno);
  final String sname;
  final String srno;
}*/

class FrmDeshborad extends StatefulWidget {
  @override
  _FrmDeshboradState createState() => _FrmDeshboradState();
}

class _FrmDeshboradState extends State<FrmDeshborad> {
  List<String> _sernof = []; // =globals.srlistpref.split('/');
  List<String> _shopname = []; // =globals.shoplistpref.split('/');
 String _selectedLocation;
 List<GetString> getData;
   //int count = 0;
 
  @override


  Widget build(BuildContext context) {
    _sernof = globals.srlistpref.split('/');
    _shopname = globals.shoplistpref.split('/');
   
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            reportHeader(),
           
            btnStock(),
            SizedBox(
              height: 1.0,
            ),
            btnSale(),
            SizedBox(
              height: 1.0,
            ),
            btnCustomer(),
            SizedBox(
              height: 1.0,
            ),
            btnSupplier(),
            SizedBox(
              height: 1.0,
            ),
            btnBalance(),
            SizedBox(
              height: 1.0,
            ),
            btnNone(),
            SizedBox(
              height: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget drpdown() {
    return 
    DropdownButton(
       elevation: 5,
      
      style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 16.0) ,
       hint: Text(
                'Please choose a shop',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
           // hint: Text('     Please choose a shop'), // Not necessary for Option 1
            value: _selectedLocation,
            
            onChanged: (newValue) {
              setState(() {
               // globals.shop = "xxxxxxx";
                _selectedLocation = newValue;
                getpossrno(_selectedLocation);
                getAuthentication();
              });
            },
            items: _shopname.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          );
    }

    void getAuthentication() async {
 
    globals.shop = "";
    globals.sType = "";
    globals.uploadDate = "";
    globals.uploadTime = "";

    APIServices.getUser(
            "http://" + globals.apipref + ":" + globals.portpref + "/AllPos/AllPosRpt/Get_String/ MultiUser = '" + globals.registerpref + "'" + "/" + globals.srnoforshop) 
        .then((reponse) {
      Iterable list = json.decode(reponse.body);
      List<GetString> userList = List<GetString>();
      userList = list.map((model) => GetString.fromObject(model)).toList();
     int count = userList.length;
      if (count != 0) {
        setState(() {
          getData = userList;
        });
        setState(() {
    globals.shop = getData[0].shop.toString();
    globals.sType = getData[0].typeOfSoft.toString();
    globals.uploadDate = getData[0].dt.toString();
    globals.uploadTime = getData[0].tm.toString();
        });
      } 
    });
  }

  getpossrno(String val) {
    for (int i = 0; i < _shopname.length; i++) {
      if (_shopname[i].toString() == val) {
        globals.srnoforshop = _sernof[i].toString();
        break;
      }
    }
  }

// Bulid Stype
  double maxHeight = 28.0;

  Widget reportHeader() {
    return Container(
      width: double.infinity,
      // height: 280,
      color: Colors.blue[700],
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 20.0, bottom: 5.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Zaw-Gyi/Unicode",
                    style: TextStyle(color: Colors.white60, fontSize: 12.0),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Switch(
                          activeColor: Colors.red,
                          activeTrackColor: Colors.grey,
                          inactiveTrackColor: Colors.grey,
                          value: globals.unicodestatus,
                          onChanged: (value) {
                            setState(() {
                              globals.unicodestatus = value;
                            });
                          }))
                  //lgnswitch()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/banner.png',
                  width: 165,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            
              Text(
                globals.sType,
                style: TextStyle(color: Colors.white),
              ),
              Divider(),
              Text(
                globals.shop,
                style: TextStyle(
                    color: Colors.white,
                    //  fontFamily: 'Pyidaungsu',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text(
                globals.uploadDate + " : " + globals.uploadTime,
                style: TextStyle(
                    color: Colors.white,
                    //fontFamily: 'Pyidaungsu',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
               Container(
                 color: Colors.blue[600],
                 child: Row(
                   
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Search Shop Name:",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Container(
                       decoration: BoxDecoration(
              color: Colors.blue[500], borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.centerRight,
                        child: drpdown()
                        )
                    //lgnswitch()
                  ],
              ),
               ),

              //Text(
              //  globals.saveDate + " :: " + globals.saveTime,
              //  style: TextStyle(color: Colors.white),
              // ),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget btnStock() {
    return SingleChildScrollView(
        child: Container(
      // height: 70.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            //height: 25.0,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmStockRpt()),
              );
            },
            //=> exit(0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/stock.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("STOCK",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

//FrmPurchaseRpt
  Widget btnSale() {
    return SingleChildScrollView(
        child: Container(
      // height: 70.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            height: 15.0,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmSaleRpt()),
              );
            },
            //() => exit(0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/sale.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("SALE REPOET",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget btnCustomer() {
    return SingleChildScrollView(
        child: Container(
      // height: 70.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            height: 15.0,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmCutomerRpt()),
              );
            },
            //() => exit(0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/customer.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("CREDIT REPORT",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget btnSupplier() {
    return SingleChildScrollView(
        child: Container(
      // height: 70.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            height: 15.0,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmSupplierRpt()),
              );
            },
            //() => exit(0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/supplier.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("DEBIT REPORT",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget btnBalance() {
    return SingleChildScrollView(
        child: Container(
      // height: 70.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            height: 15.0,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmBalanceRpt()),
              );
            },
            //() => exit(0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/report.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("ALL REPORT",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget btnNone() {
    return SingleChildScrollView(
        child: Container(
      // height: 70.0,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            height: 15.0,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => exit(0),
            /* onPressed: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DropdownScreen()),
              );
            },*/
            //() => exit(0),
            child: Text("EXIT",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 16.0)),
          ),
        ),
      ),
    ));
  }
}

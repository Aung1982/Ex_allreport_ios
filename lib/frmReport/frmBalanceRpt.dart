import 'dart:async';
import 'package:flutter/material.dart';
import 'package:excellent_all_pos_report/modules/api.services.dart';
import 'dart:convert';
import 'package:excellent_all_pos_report/modules/ModelStock.dart';
import 'package:excellent_all_pos_report/modules/global.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

//import 'package:excellent_all_pos_report/frmReport/detailsStock.dart';

class FrmBalanceRpt extends StatefulWidget {
  @override
  _FrmBalanceRptState createState() => _FrmBalanceRptState();
}

class _FrmBalanceRptState extends State<FrmBalanceRpt> {
  List<ModelStock> lpd;

  bool fitstLoad = false;
  bool findLoad = false;
  String czfont = globals.zfonts;

  final TextEditingController txtFindBy = new TextEditingController();
  final TextEditingController txtData = new TextEditingController();
  final currencyFormatter = NumberFormat("###,###,###,###,##0.00", 'en_US');
  //TextStyle style = TextStyle(fontFamily: 'Zawgyi-One', fontSize: 12.0);

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
          actions: <Widget>[],
          title: Text('REPORT'),
        ),
        body: bodyLoad()
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
                            if (lpd[index].itemID.toString() == "") {
                              return unnormaldata(lpd[index].itemName);
                            }
                            {
                              return normaldata(lpd[index].itemID,
                                  lpd[index].itemName, lpd[index].quantity);
                            }
                          })),
        ],
      ),
    );
  }

  Widget normaldata(String itID, String itName, double qty) {
    return Card(
      elevation: 3.0,
      child: InkWell(
        onTap: () //{
            {},
        child: ListTile(
          //isThreeLine: true,
          title: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    itID.toString() + ". " + itName.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0 ,fontFamily:  czfont),
                  ),
                
                ],
              ),
            ],
          ),
          subtitle: Column(
            children: <Widget>[
              Container(
                //margin: new EdgeInsets.only(left: 80.0),

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
        ),
      ),
    );
  }

  Widget unnormaldata(String itName) {
    return Card(
      elevation: 3.0,
      child: InkWell(
        onTap: () //{
            {},
        child: ListTile(
          // isThreeLine: true,
          title: Text(
            itName.toString(),style:  TextStyle(fontFamily:  czfont),
          ),
        ),
      ),
    );
  }
// globals.portpref +
  void getAuthentication() async {
    if (fitstLoad == false) {
      APIServices.getUser("http://" +
              globals.apipref + ":" + globals.portpref +
              "/AllPos/AllPosRpt/Get_Report/Where MultiUser = N'" +
              globals.srnoforshop +
              "'/" +  globals.unicodestatus.toString())
          .then((reponse) {
        Iterable list = json.decode(reponse.body);
        List<ModelStock> userList = List<ModelStock>();
        userList = list.map((model) => ModelStock.fromObject(model)).toList();
        int count = userList.length;
        if (count != 0) {
          setState(() {
            lpd = userList;
            fitstLoad = true;
          });
        }
      });
    }
  }
}

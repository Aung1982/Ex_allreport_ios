import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'fade_ani.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:excellent_all_pos_report/modules/api.services.dart';
import 'package:excellent_all_pos_report/modules/global.dart' as globals;
import 'package:excellent_all_pos_report/modules/GetString.dart';
import 'package:excellent_all_pos_report/frmReport/frmDeshboard.dart';

class FrmLogin extends StatefulWidget {
  @override
  _FrmLoginState createState() => _FrmLoginState();
}

class _FrmLoginState extends State<FrmLogin> {
  @override
  void initState() {
    super.initState();
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController txtUsrId = new TextEditingController();
  final TextEditingController txtUsrName = new TextEditingController();

  final TextEditingController txtUName = new TextEditingController();
  final TextEditingController txtOPwd = new TextEditingController();
  final TextEditingController txtNPwd = new TextEditingController();
  //bool _isButtonDisabled = false;
  //final TextEditingController btnSign = new TextEditingController();
  List<GetString> getData;
  int count = 0;
  String serno = globals.registerpref;

  @override
  Widget build(BuildContext context) {
    final usrNameField = TextField(
      controller: txtUsrName,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "User Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    final passwordField = TextField(
      controller: txtUsrId,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // Usr = N'" + id + "'";
          // {SELECT TOP (200) AID, Usr, Shop, Amt, MultiUser, PhNo, Password, RegDate, Peroid, TypeOfSoft, OnOff  FROM TblUser
          String str = " Usr = N'" +
              txtUsrName.text +
              "' and Password = N'" +
              txtUsrId.text +
              "' and MultiUser = N'" +
              serno +
              "'";
          getAuthentication(str);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
      ),
    );

 final chnagepwd = Material(
     // elevation: 5.0,
     /// borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
      child: FlatButton(
       // minWidth: MediaQuery.of(context).size.width,
      //  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // Usr = N'" + id + "'";
          // {SELECT TOP (200) AID, Usr, Shop, Amt, MultiUser, PhNo, Password, RegDate, Peroid, TypeOfSoft, OnOff  FROM TblUser
         /* String str = " Usr = N'" +
              txtUsrName.text +
              "' and Password = N'" +
              txtUsrId.text +
              "' and MultiUser = N'" +
              serno +
              "'";
          getAuthentication(str);*/
          _showDialog();
        },
        child: Text("CHANGE PASSWORD",
            textAlign: TextAlign.center,
            style: style.copyWith(
              decoration: TextDecoration.underline,
                color: Colors.blue[200], fontWeight: FontWeight.normal)),
      ),
    );

    final exitButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => exit(0),
        child: Text("Exit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.normal)),
      ),
    );

//void bool login()
    return WillPopScope(
        onWillPop: () {
          print(
              'Backbutton pressed (device or appbar button), do whatever you want.');
          Navigator.pop(context, false);
          exit(0);
          //we need to return a future
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  //alignment: Alignment.center,
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 150.0,
                          child: Image.asset(
                            "assets/rptiogo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        // SizedBox(height: 45.0),
                        // emailField,
                        Text("EXCELLENT BUSINESS SOLUTION Co.Ltd;",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0)),
                        SizedBox(height: 30.0),
                        FadeAnimation(1.6, usrNameField),
                        SizedBox(
                          height: 15.0,
                        ),
                        FadeAnimation(1.6, passwordField),
                      
                        FadeAnimation(1.6, chnagepwd),
                       

                        Padding(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: FadeAnimation(1.6, loginButon)),
                              Container(
                                width: 5.0,
                              ),
                              Expanded(child: FadeAnimation(1.6, exitButon)),
                            ],
                          ),
                        ),

                        // FadeAnimation(1.6, loginButon),
                        //   exitButon,
                        // SizedBox(
                        //    height: 260.0,
                        //  ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: Container(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: txtUName,
                obscureText: false,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "User Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
               SizedBox(height: 10.0),
              TextField(
                controller: txtOPwd,
                obscureText: false,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Old Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: txtNPwd,
                obscureText: false,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "New Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
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
                child: const Text('CHNAGE'),
                onPressed: () {
                  //Navigator.pop(context);
                  setState(() {
                     _searchData();
                  });
                })
          ],
        ),
      ),
    );
  }

void _searchData() {
    String uname = txtUName.text.toString();
    String opwd = txtOPwd.text.toString();
String npwd = txtNPwd.text.toString();
       if (uname != "" && opwd != "" && npwd !="") {
           String str = " Usr = N'" +
              uname +
              "' and Password = N'" +
              opwd +
              "' and MultiUser = N'" +
              serno +
              "'";
      getChPwd(str,npwd);
    } else {
      Fluttertoast.showToast(
          msg: "Fill data complete!",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  void getChPwd(String val,String oldpwd) async {
  
       APIServices.getUser("http://" +
            globals.apipref +
            ":" +
            globals.portpref +
            "/AllPos/AllPosRpt/Get_ChPwd/" +
            val +
            "/" +
            oldpwd)
        .then((reponse) {
      Iterable list = json.decode(reponse.body);
      List<GetString> userList = List<GetString>();
      userList = list.map((model) => GetString.fromObject(model)).toList();
      count = userList.length;
      if (count != 0) {
        setState(() {
          Fluttertoast.showToast(
            msg: "Password change successfully",
            backgroundColor: Colors.black,
            textColor: Colors.white);
            Navigator.pop(context);
        });
        
      //  setState(() {
       //   loadlogin();
       // });
      } else {
        Fluttertoast.showToast(
            msg: "Wrong Username and Password!",
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    });
  }

  void getAuthentication(String val) async {
    if (val == "") {
      return null;
    }
    globals.shop = "";
    globals.sType = "";
    globals.uploadDate = "";
    globals.uploadTime = "";
    globals.srlistpref = "";
    globals.shoplistpref = "";
    // string sq = "Select top(1) AID From TblUser Where Usr = N'" + id + "'";
    // {SELECT TOP (200) AID, Usr, Shop, Amt, MultiUser, PhNo, Password, RegDate, Peroid, TypeOfSoft, OnOff  FROM TblUser
    APIServices.getUser("http://" +
            globals.apipref +
            ":" +
            globals.portpref +
            "/AllPos/AllPosRpt/Get_String/" +
            val +
            "/" +
            serno)
        .then((reponse) {
      Iterable list = json.decode(reponse.body);
      List<GetString> userList = List<GetString>();
      userList = list.map((model) => GetString.fromObject(model)).toList();
      count = userList.length;
      if (count != 0) {
        setState(() {
          getData = userList;
        });
        setState(() {
          loadlogin();
        });
      } else {
        Fluttertoast.showToast(
            msg: "Wrong Username and Password!",
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    });
  }

  void loadlogin() {
    globals.shop = getData[0].shop.toString();
    globals.sType = getData[0].typeOfSoft.toString();
    globals.uploadDate = getData[0].dt.toString();
    globals.uploadTime = getData[0].tm.toString();
    globals.srlistpref = getData[0].srlist.toString();
    globals.shoplistpref = getData[0].shplist.toString();
    if (globals.shop != "" && globals.shop != null) {
      // _save(globals.eID);
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FrmDeshborad()),
        );
      });
    } else {
      // _isButtonDisabled = false;
      Fluttertoast.showToast(
          msg: "Wrong Username and Password!",
          backgroundColor: Colors.black,
          textColor: Colors.white);

    }
  }

  void _save(String val) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    String formattedTime = DateFormat('H:m:s').format(now);
    // var myFormat = DateFormat('d-MM-yyyy');
    String str = "update Tbl_Mark set vDate='" +
        formattedDate +
        "',vTime = '" +
        formattedTime +
        "' where E_ID = N'" +
        val +
        "'";

    Map data = {'name': str};
    await APIServices.postRegister(data);
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'fade_ani.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:excellent_all_pos_report/modules/api.services.dart';
import 'package:excellent_all_pos_report/frmSplesh/frm_login.dart';
import 'package:excellent_all_pos_report/modules/ModelStock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:excellent_all_pos_report/modules/global.dart' as globals;

class FrmRegister extends StatefulWidget {
  @override
  _FrmRegisterState createState() => _FrmRegisterState();
}

class _FrmRegisterState extends State<FrmRegister> {
  @override
  void initState() {
    super.initState();
  }

  SharedPreferences sharedPreferences;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);
  final TextEditingController txtUsrName = new TextEditingController();

  List<ModelStock> getData;
  int count = 0;
//  String serno = "XxK3kk83";

  @override
  Widget build(BuildContext context) {
    final usrNameField = TextField(
      controller: txtUsrName,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Serial No.",
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
          String str = " MultiUser = N'" + txtUsrName.text + "'";
          getAuthentication(str);
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
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
          //trigger leaving and use own data
          Navigator.pop(context, false);
          exit(0);
          //we need to return a future
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor:  Colors.white,
            body: Center(
              child: SingleChildScrollView(
          child: Container(
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
                        "assets/pos_logo.png",
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

                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                    SizedBox(
                      height: 260.0,
                    ),
                  ],
                ),
              ),
          ),
        ),
            )));
  }

  void getAuthentication(String val) async {
    if (val == "") {
      return null;
    }
    // string sq = "Select top(1) AID From TblUser Where Usr = N'" + id + "'";
    // {SELECT TOP (200) AID, Usr, Shop, Amt, MultiUser, PhNo, Password, RegDate, Peroid, TypeOfSoft, OnOff  FROM TblUser
    APIServices.getUser(
            "http://" + globals.apipref + ":" + globals.portpref + "/AllPos/AllPosRpt/Get_Reg/" + val)
        .then((reponse) {
      Iterable list = json.decode(reponse.body);
      List<ModelStock> userList = List<ModelStock>();
      userList = list.map((model) => ModelStock.fromObject(model)).toList();
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
            msg: "Wrong Serial no. (or) doesn't register from Excellent!",
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    });
  }

  void loadlogin() {
    if (getData[0].aID != 0 && getData[0].aID != null) {
      _onSavePref();
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FrmLogin()),
        );
      });
    } else {
      // _isButtonDisabled = false;
      Fluttertoast.showToast(
          msg: "Wrong Serial no. or doesn't register from Excellent!",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  _onSavePref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("regsrno", txtUsrName.text);
       globals.registerpref = txtUsrName.text;
    });
  }

/*
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
  }*/
}

/*import 'package:connectivity/connectivity.dart';
import 'package:excellent_all_pos_report/frmSplesh/frmRegApi.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../frmsplesh/frm_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:excellent_all_pos_report/modules/global.dart' as globals;
import 'package:excellent_all_pos_report/frmSplesh/frmRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
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
          body: Stack(fit: StackFit.expand, children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 79, 128, 190)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          //backgroundColor: Colors.
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Image(
                              image:
                                  AssetImage('assets/multi_report_logo.png')),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                          "Excellent ALL POS REPORT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("Loading....",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            )
          ]),
        ));
  }

  /*
_selectpage() {
  globals.register_pref = "";

  if ( globals.register_pref == ""){
 MaterialPageRoute(builder: (context) => FrmLogin());
  }
  else
  {
 MaterialPageRoute(builder: (context) => FrmRegister());
  }
}
*/
  ceckGetPerf() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      globals.apipref = sharedPreferences.getString("apipref");
      globals.portpref = sharedPreferences.getString("portpref");
      globals.registerpref = sharedPreferences.getString("regsrno");
      if (globals.apipref == null ||
          globals.apipref == "" ||
          globals.portpref == null ||
          globals.portpref == "") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FrmRegApi()),
        );
      } else {
        if (globals.registerpref == null || globals.registerpref == "") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FrmRegister()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FrmLogin()),
          );
        }
      }
    });
  }

/*
 _onSavePref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
     
          sharedPreferences.setString("regsrno", txt.text);
    
      getCredential();
    });
  }
*/
  _checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "You're not connected to a network!",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      Timer(Duration(seconds: 5), () => exit(0));
    } else {
      Timer(
        Duration(seconds: 3),
        () => ceckGetPerf(),
      );

      //  Timer(Duration(seconds: 3), ()=> Navigator.push(context,
      //  ceckGetPerf(),)
      // );
    }
  }
}*/

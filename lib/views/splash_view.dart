import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lovelydialogs/lovely_dialogs.dart';
import 'package:notespedia/views/homeView.dart';
import 'package:notespedia/views/networkStatus.dart';
import 'package:notespedia/views/phoneAuth.dart';
import 'phoneAuth.dart';
import 'package:notespedia/models/userDataModel.dart';
import 'profileBuild.dart';
import 'package:notespedia/service/firebaseService.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Image(
                  image: AssetImage("assets/images/logo2.png"),
                  height: 100,
                  width: 100,
                ),
              ),
              Text(
                "Made in ♥ India",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontFamily: "OpenSans-Regular",
                  fontSize: 12,
                ),
              )
            ],
          ),
        ));
  }

  checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      String getPhoneNumber(String phNumber) {
        fPhNumber = phNumber;
      }

      firebaseService().getUserPhoneNumber().then((value) {
        getPhoneNumber(value);
      });

      checkIfUserLoggedIn();
    } else if (result == ConnectivityResult.none) {
      LovelyInfoDialog(
        context: context,
        title: 'Oh Snap!',
        leading: Image(
          image: AssetImage(
              "assets/images/noInternetIllustration.png"),
        ),
        description: 'You lost internet connection!',
        onConfirm: () {
          initState();
        },
        confirmString: "Retry",
        touchDismissible: false,
      ).show();
    }
  }

  Future checkIfUserLoggedIn() async {
    //Check if User Logged In.
    if (await FirebaseAuth.instance.currentUser() != null) {
      FirebaseDatabase.instance
          .reference()
          .child("Notespedia/USERS/" + fPhNumber)
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value != null) {


          userDataModel userdatamodel =
              new userDataModel.fromSnapshot(dataSnapshot);
          print(userdatamodel.getUserName);

          Timer(
              Duration(seconds: 1),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => homeView(
                        userdatamodel: userdatamodel,
                      ))));
        } else {
          Timer(
              Duration(seconds: 1),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => profileBuild())));
        }
      });
    } else {
      // If not
      Timer(
          Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => phoneAuth())));
    }
  }
}

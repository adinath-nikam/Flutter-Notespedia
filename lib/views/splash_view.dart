import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notespedia/views/homeView.dart';
import 'package:notespedia/views/phoneAuth.dart';
import 'phoneAuth.dart';
import 'profileBuild.dart';
import 'package:notespedia/service/firebaseService.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkIfUserLoggedIn();
    super.initState();
  }

  Future _checkIfUserLoggedIn() async {
    //Check if User Logged In.
    if (await FirebaseAuth.instance.currentUser() != null) {
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .reference()
          .child("Notespedia/USERS/+919113910407");
      // ignore: unrelated_type_equality_checks
      userNode(databaseReference).then((value) {
        if (value == true) {
          Timer(
              Duration(seconds: 1),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => homeView())));
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

  // Check if User Node is Present in RLTDB
  Future<bool> userNode(DatabaseReference databaseReference) async {
    DataSnapshot snapshot = await databaseReference.once();
    if (snapshot.value == null) {
      return false;
    } else {
      return true;
    }
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
              Image(
                image: AssetImage("assets/images/logo.png"),
                height: 250.0,
                width: 250.0,
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                "Made in ♥ India",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontFamily: "font_primary",
                  fontSize: 15,
                ),
              )
            ],
          ),
        ));
  }
}

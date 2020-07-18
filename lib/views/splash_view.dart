import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notespedia/views/homeView.dart';
import 'package:notespedia/views/phoneAuth.dart';

import 'phoneAuth.dart';
import 'profileBuild.dart';



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
    // If User already Logged In
      Timer(
          Duration(seconds: 3),
              () =>
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => profileBuild()
                  )
              )
      );
    } else {
    // If not
      Timer(
          Duration(seconds: 3),
              () =>
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => phoneAuth()
                  )
              )
      );
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
              SizedBox(height: 80,),
              Text(
                "Made in ♥ India",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: "font_primary",
                    fontSize: 15,),
              )
            ],
          ),
        )
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'splash_view.dart';

class homeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Logout"),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => SplashScreen()
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}

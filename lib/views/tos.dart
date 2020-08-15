import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class termsofService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.lightBlue,
            child: Column(
              children: <Widget>[
                Text("Terms of Service"),
                Text("Updated on 11 March, 2020"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(12),
            child: Text("Terms of Service"),
          )
        ],
      ),
    );
  }
}

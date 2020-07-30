import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 50,
                  width: 180,
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

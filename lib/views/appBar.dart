import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 50,
                  width: 180,
                )),
          ),
        ],
      ),
    );
  }
}

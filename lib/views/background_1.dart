import 'package:flutter/material.dart';


class background extends StatelessWidget {

  String image;
  background(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            height: 300,
            child: Image(
              image: AssetImage(image),
              height: 200,
              width: 200,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.lightBlue,
            ),
          )
        ],
      ),
    );
  }
}
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notespedia/models/userDataModel.dart';

class homeProfileCardView extends StatelessWidget {

  final userDataModel userdatamodel;
  homeProfileCardView({this.userdatamodel});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                "Hi,\n"+userdatamodel.getUserName,
                style: TextStyle(
                  fontFamily: "OpenSans-Bold",
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                maxLines: 2,
              ),
              SizedBox(
                width: 80,
              ),
              new Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                      image: new AssetImage(
                          "assets/images/circularProfileImage.png"),
                      fit: BoxFit.cover),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.lightBlue,
                    width: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
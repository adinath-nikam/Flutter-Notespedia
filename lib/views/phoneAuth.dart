import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class phoneAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: phoneAuthBody(),
      ),
    );
  }
}

class phoneAuthBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[background(), authCard()],
      ),
    );
  }
}

class background extends StatelessWidget {
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
              image: AssetImage("assets/images/phoneAuth_illustration.jpg"),
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

class authCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Card(
          elevation: 20.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 150,
                  width: 150,
                ),
                Text(
                  "Verify your Phone Number.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "font_primary",
                      color: Colors.grey[500],
                  ),
                ),
                Form(
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (String value){
                      if(value.isEmpty){
                        return "Required!";
                      }else if(value.length < 10){
                        return "Invalid Phone Number!";
                      }
                    },
                    maxLength: 10,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "+91",
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.lightBlue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.lightBlue),
                      ),
                      border: OutlineInputBorder(
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 40,
                  width: 400,
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: (){},
                    child: Text(
                      "Get OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "font_primary"
                      ),
                    )
                  ),
                ),
                Divider(
                  color: Colors.lightBlue,
                  height: 20,
                ),
                Text(
                  "By Signing In, you Agree to our Terms and Conditions*.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

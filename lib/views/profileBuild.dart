import 'package:flutter/material.dart';
import 'authTosWidget.dart';
import 'background_1.dart';

class profileBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileBuildBody(),
    );
  }
}

class profileBuildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          background(""),
          profileBuildCard()
        ],
      ),
    );
  }
}


// OTP Auth Elevated Card
class profileBuildCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                        "Let's Build your Profile!,.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "font_primary",
                          color: Colors.grey[500],
                        ),
                      ),
                      profileForm(),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: 400,
                        child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () {},
                            child: Text(
                              "Verify OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "font_primary"),
                            )),
                      ),
                      Divider(
                        color: Colors.lightBlue,
                        height: 20,
                      ),
                      authTosWidget(),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

//Profile Form
class profileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: <Widget>[
//            Username
            TextFormField(
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return "Required!";
                } else if (value.length < 21) {
                  return "Invalid Phone Number!";
                }
              },
              maxLength: 21,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.lightBlue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide:
                  BorderSide(width: 2, color: Colors.lightBlue),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
//            Email
            TextFormField(
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return "Required!";
                } else if (value.length < 10) {
                  return "Invalid Phone Number!";
                }
              },
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "username@example.com",
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.lightBlue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide:
                  BorderSide(width: 2, color: Colors.lightBlue),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notespedia/views/authTosWidget.dart';
import 'background_1.dart';
import 'homeView.dart';

//OTP Auth Main
class otpAuth extends StatelessWidget {

  //  Variable Declarations
  final otpTextEditController = TextEditingController();
  dynamic verificationId, sharedOtpVal, _otpVal;
  final _otpFormKey = GlobalKey<FormState>();

  otpAuth({@required this.verificationId});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: otpAuthBody(context),
      ),
    );
  }

// OTP Auth Body
  otpAuthBody(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          background("assets/images/otpIllustration.png"),
          otpAuthCard(context),
        ],
      ),
    );
  }

//  OTP Auth Card
  otpAuthCard(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
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
                        "Enter OTP, Send to your Phone Number.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "font_primary",
                          color: Colors.grey[500],
                        ),
                      ),
                      Form(
                        key: _otpFormKey,
                        child: TextFormField(
                          controller: otpTextEditController,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Required!";
                            } else if (value.length < 6) {
                              return "Invalid OTP Code!";
                            }
                          },
                          maxLength: 6,
                          maxLines: 1,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "* * * *",
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.lightBlue,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.lightBlue),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: 400,
                        child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () async {
                              if (_otpFormKey.currentState.validate()) {
                                _otpVal = otpTextEditController.text.trim();
                                AuthCredential authcredential = PhoneAuthProvider
                                    .getCredential(
                                    verificationId: verificationId, smsCode: _otpVal);
                                AuthResult authresult = await FirebaseAuth.instance
                                    .signInWithCredential(authcredential);
                                FirebaseUser firebaseuser = authresult.user;

                                if (firebaseuser != null) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => homeView()
                                  ));
                                } else {
                                  print("Error: Error on navigating to home.");
                                }
                              }
                            },
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

////////////////////////////////////////////////////////////////////////////////




// OTP Auth Body
//class otpAuthBody extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Stack(
//        children: <Widget>[
//          background("assets/images/otpIllustration.png"),
//          otpAuthCard(),
//        ],
//      ),
//    );
//  }
//}

// OTP Auth Elevated Card
//class otpAuthCard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return SingleChildScrollView(
//      child: Container(
//          margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
//          child: Center(
//            child: Padding(
//              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//              child: Card(
//                elevation: 20.0,
//                child: Padding(
//                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Image(
//                        image: AssetImage("assets/images/logo.png"),
//                        height: 150,
//                        width: 150,
//                      ),
//                      Text(
//                        "Enter OTP, Send to your Phone Number.",
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          fontSize: 14,
//                          fontFamily: "font_primary",
//                          color: Colors.grey[500],
//                        ),
//                      ),
//                      Form(
//                        child: TextFormField(
//                          // ignore: missing_return
//                          validator: (String value) {
//                            if (value.isEmpty) {
//                              return "Required!";
//                            } else if (value.length < 10) {
//                              return "Invalid Phone Number!";
//                            }
//                          },
//                          maxLength: 6,
//                          maxLines: 1,
//                          keyboardType: TextInputType.phone,
//                          textAlign: TextAlign.center,
//                          decoration: InputDecoration(
//                            hintText: "* * * *",
//                            prefixIcon: Icon(
//                              Icons.vpn_key,
//                              color: Colors.lightBlue,
//                            ),
//                            enabledBorder: OutlineInputBorder(
//                              borderRadius: BorderRadius.all(Radius.circular(4)),
//                              borderSide:
//                                  BorderSide(width: 2, color: Colors.lightBlue),
//                            ),
//                            border: OutlineInputBorder(),
//                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      SizedBox(
//                        height: 40,
//                        width: 400,
//                        child: RaisedButton(
//                            color: Colors.lightBlue,
//                            onPressed: () {},
//                            child: Text(
//                              "Verify OTP",
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontFamily: "font_primary"),
//                            )),
//                      ),
//                      Divider(
//                        color: Colors.lightBlue,
//                        height: 20,
//                      ),
//                      authTosWidget(),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          )),
//    );
//  }
//}

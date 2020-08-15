import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notespedia/views/authTosWidget.dart';
import 'background_1.dart';
import 'homeView.dart';
import 'profileBuild.dart';
import 'splash_view.dart';

//OTP Auth Main
class otpAuth extends StatefulWidget {
  var verificationId;


  //  Variable Declarations

  otpAuth({@required this.verificationId});

  @override
  _otpAuthState createState() => _otpAuthState();
}

class _otpAuthState extends State<otpAuth> {
  final otpTextEditController = TextEditingController();

  dynamic verificationId, sharedOtpVal, _otpVal;

  final _otpFormKey = GlobalKey<FormState>();

  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: otpAuthBody(context),
      ),
    );
  }

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

  progressBarState(bool state){
    setState(() {
      _loading = state;
    });
  }

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
                            hintText: "* * * * * *",
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
                              progressBarState(true);
                              if (_otpFormKey.currentState.validate()) {
                                _otpVal = otpTextEditController.text.trim();
                                AuthCredential authcredential = PhoneAuthProvider
                                    .getCredential(
                                    verificationId: widget.verificationId, smsCode: _otpVal);
                                AuthResult authresult = await FirebaseAuth.instance
                                    .signInWithCredential(authcredential);
                                FirebaseUser firebaseuser = authresult.user;

                                if (firebaseuser != null) {
                                  progressBarState(false);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => SplashScreen()
                                  ));
                                } else {
                                  progressBarState(false);
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
                      SizedBox(height: 10,),
                      _loading ? LinearProgressIndicator() : SizedBox(height: 1,),
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notespedia/views/authTosWidget.dart';
import 'package:notespedia/views/profileBuild.dart';
import 'background_1.dart';
import 'background_1.dart';
import 'homeView.dart';
import 'otpAuth.dart';



//Phone Auth Main
class phoneAuth extends StatelessWidget {

  //  Variable Declarations
  final _phoneNumberTextEditController = TextEditingController();
  dynamic phoneNumberVal;
  final _phoneFormKey = GlobalKey<FormState>();





  // Authentication
  Future <bool> Authentication(String phoneNumber, BuildContext context) async{
    FirebaseAuth _fAuth = FirebaseAuth.instance;

    _fAuth.verifyPhoneNumber(

        //Phone Number
        phoneNumber: phoneNumber,

        // Timeout Duration
        timeout: Duration(seconds: 60),

        //Verification Completed
        verificationCompleted: (AuthCredential credential) async {
          AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
          FirebaseUser firebaseUser = authResult.user;
          if (firebaseUser != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => homeView()));
          }
        },

        //Verification Failed
        verificationFailed: (AuthException authexception){
          print(authexception.message);
        },

        //On CodeSent to Phone Number
        codeSent: (String verificationId, [int forceResendingToken]){

          Navigator.push(context, MaterialPageRoute(
              builder: (context) => otpAuth(verificationId: verificationId,)
          ));

        },
        codeAutoRetrievalTimeout: null);

  }











  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: phoneAuthBody(context),
      ),
    );
  }


//  Phone Auth Body
  phoneAuthBody(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          background("assets/images/phoneAuth_illustration.jpg"),
          phoneAuthCard(context),
        ],
      ),
    );
  }

//  Phone Auth Card
  phoneAuthCard(BuildContext context) {
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
                        "Verify your Phone Number.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "font_primary",
                          color: Colors.grey[500],
                        ),
                      ),
                      Form(
                        key: _phoneFormKey,
                        child: TextFormField(
                          controller: _phoneNumberTextEditController,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Required!";
                            } else if (value.length < 10) {
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
                            onPressed: () {
                              if (_phoneFormKey.currentState.validate()) {
                                phoneNumberVal = "+91" + _phoneNumberTextEditController.text.trim();
                                Authentication(phoneNumberVal, context);
                              }
                            },
                            child: Text(
                              "Get OTP",
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





//// Phone Auth Body
//class phoneAuthBody extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Stack(
//        children: <Widget>[
//          background("assets/images/phoneAuth_illustration.jpg"),
//          phoneAuthCard(),
//        ],
//      ),
//    );
//  }
//}

// Phone Auth Elevated Card
//class phoneAuthCard extends StatefulWidget {
//  @override
//  _phoneAuthCardState createState() => _phoneAuthCardState();
//}
//
//class _phoneAuthCardState extends State<phoneAuthCard> {
//  bool _loading;
//
//  @override
//  void initState() {
//    super.initState();
//    _loading = false;
//  }
//
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
//                      _loading
//                          ? LinearProgressIndicator()
//                          : Text("Press button to download"),
//                      Image(
//                        image: AssetImage("assets/images/logo.png"),
//                        height: 150,
//                        width: 150,
//                      ),
//                      Text(
//                        "Verify your Phone Number.",
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          fontSize: 18,
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
//                          maxLength: 10,
//                          maxLines: 1,
//                          keyboardType: TextInputType.phone,
//                          decoration: InputDecoration(
//                            hintText: "+91",
//                            prefixIcon: Icon(
//                              Icons.phone,
//                              color: Colors.lightBlue,
//                            ),
//                            enabledBorder: OutlineInputBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(4)),
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
//                            onPressed: () {
//                              setState(() {
//                                _loading = !_loading;
//                              });
//                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => profileBuild()));
//                            },
//                            child: Text(
//                              "Get OTP",
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

//class progressIndicator extends StatefulWidget {
//  @override
//  progressIndicatorState createState() => progressIndicatorState();
//}
//
//class progressIndicatorState extends State<progressIndicator> {
//  bool _loading;
//
//  @override
//  void initState() {
//    super.initState();
//    _loading = false;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: _loading ? LinearProgressIndicator() : Text("Press button to download"),
//    );
//  }
//}
//

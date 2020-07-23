import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notespedia/models/userDataModel.dart';
import 'package:notespedia/service/firebaseService.dart';
import 'authTosWidget.dart';
import 'background_1.dart';
import 'homeView.dart';

final userNameTextEditController = TextEditingController();
final userEmailTextEditController = TextEditingController();
final _profileFormKey = GlobalKey<FormState>();
final _streamsDropdownFormKey = GlobalKey<FormState>();
final _institutesDropdownFormKey = GlobalKey<FormState>();
final _semestersDropdownFormKey = GlobalKey<FormState>();
final _gendersDropdownFormKey = GlobalKey<FormState>();

String fUid, fPhNumber;
var selectedStream, selectedSemester, selectedInstitute, selectedGender;
List<streamsModelClass> streamsList = [];

class profileBuild extends StatefulWidget {
  @override
  _profileBuildState createState() => _profileBuildState();
}

class _profileBuildState extends State<profileBuild> {
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  progressBarState(bool state) {
    setState(() {
      _loading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    String getUid(String uid) {
      fUid = uid;
    }

    String getPhoneNumber(String phNumber) {
      fPhNumber = phNumber;
    }

    firebaseService().getFirebaseUserId().then((value) {
      getUid(value);
    });
    firebaseService().getUserPhoneNumber().then((value) {
      getPhoneNumber(value);
    });

    return Scaffold(
      body: profileBuildBody(),
    );
  }

  profileBuildBody() {
    return Center(
      child: Stack(
        children: <Widget>[background(""), profileBuildCard()],
      ),
    );
  }

  profileBuildCard() {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                        height: 50,
                        width: 400,
                        child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () {
                              if (_profileFormKey.currentState.validate()) {
                                if (selectedStream == null) {
                                  print("No Stream Data");
                                } else {
                                  progressBarState(true);
                                  userDataModel userdatamodel =
                                      new userDataModel(
                                          fUid,
                                          userNameTextEditController.text
                                              .toString(),
                                          userEmailTextEditController.text
                                              .toString(),
                                          selectedStream,
                                          selectedSemester,
                                          fPhNumber,
                                          selectedInstitute,
                                          selectedGender,
                                          new DateFormat()
                                              .format(DateTime.now()));

                                  FirebaseDatabase.instance
                                      .reference()
                                      .child("Notespedia/USERS/" + fPhNumber)
                                      .set(userdatamodel.toJson())
                                      .whenComplete(() {
                                    print('UPLOAD SUCCESSFUL');
                                    progressBarState(false);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                homeView()));
                                  });
                                }
                              }
                            },
                            child: Text(
                              "Create Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "font_primary"),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _loading
                          ? LinearProgressIndicator()
                          : SizedBox(
                              height: 1,
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
class profileForm extends StatefulWidget {
  @override
  _profileFormState createState() => _profileFormState();
}

class _profileFormState extends State<profileForm> {
  @override
  void initState() {
    selectedStream = null;
    selectedSemester = null;
    selectedGender = null;
    selectedInstitute = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _profileFormKey,
        child: Column(
          children: <Widget>[
//            Username
            TextFormField(
              controller: userNameTextEditController,
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return "Required!";
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
                  borderSide: BorderSide(width: 2, color: Colors.lightBlue),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
//            Email
            TextFormField(
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return "Required!";
                }
              },
              controller: userEmailTextEditController,
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
                  borderSide: BorderSide(width: 2, color: Colors.lightBlue),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Streams Dropdown

            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("STREAMS").snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    const Text("Loading.....");
                  else {
                    List<DropdownMenuItem> streamsItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      streamsItems.add(
                        DropdownMenuItem(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              snap.documentID,
                            ),
                          ),
                          value: "${snap.documentID}",
                        ),
                      );
                    }
                    return Container(
                        child: streamsItems.length == 0
                            ? Text('No Data')
                            : DropdownButtonFormField(
                                validator: (value) =>
                                    value == null ? 'Required!' : null,
                                decoration: InputDecoration(
                                  hintText: "Select Your Stream",
                                  prefixIcon: Icon(
                                    Icons.school,
                                    color: Colors.lightBlue,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.lightBlue),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedStream = value;
                                  });
                                },
                                items: streamsItems,
                                isExpanded: true,
                              ));
                  }
                }),

            // Streams Dropdown
            SizedBox(
              height: 20,
            ),
            // Semesters Dropdown

            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("SEMESTERS").snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    const Text("Loading.....");
                  else {
                    List<DropdownMenuItem> semestersItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      semestersItems.add(
                        DropdownMenuItem(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              snap.documentID,
                            ),
                          ),
                          value: "${snap.documentID}",
                        ),
                      );
                    }
                    return Container(
                        child: semestersItems.length == 0
                            ? Text('No Data')
                            : DropdownButtonFormField(
                                validator: (value) =>
                                    value == null ? 'Required!' : null,
                                decoration: InputDecoration(
                                  hintText: "Select Your Semester",
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: Colors.lightBlue,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.lightBlue),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedSemester = value;
                                  });
                                },
                                items: semestersItems,
                                isExpanded: true,
                              ));
                  }
                }),

            // Semesters Dropdown
            SizedBox(
              height: 20,
            ),
            // Colleges Dropdown

            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("INSTITUTES").snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    const Text("Loading.....");
                  else {
                    List<DropdownMenuItem> instituteItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      instituteItems.add(
                        DropdownMenuItem(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              snap.documentID,
                            ),
                          ),
                          value: "${snap.documentID}",
                        ),
                      );
                    }
                    return Container(
                        child: instituteItems.length == 0
                            ? Text('No Data')
                            : DropdownButtonFormField(
                                validator: (value) =>
                                    value == null ? 'Required!' : null,
                                decoration: InputDecoration(
                                  hintText: "Select Your Institute",
                                  prefixIcon: Icon(
                                    Icons.business,
                                    color: Colors.lightBlue,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.lightBlue),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedInstitute = value;
                                  });
                                },
                                items: instituteItems,
                                isExpanded: true,
                              ));
                  }
                }),

            // CollegesDropdown
            SizedBox(
              height: 20,
            ),
            // Gender Dropdown

            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("GENDERS").snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    const Text("Loading.....");
                  else {
                    List<DropdownMenuItem> genderItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      genderItems.add(
                        DropdownMenuItem(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              snap.documentID,
                            ),
                          ),
                          value: "${snap.documentID}",
                        ),
                      );
                    }
                    return Container(
                        child: genderItems.length == 0
                            ? Text('No Data')
                            : DropdownButtonFormField(
                                validator: (value) =>
                                    value == null ? 'Required!' : null,
                                decoration: InputDecoration(
                                  hintText: "Select Your Gender",
                                  prefixIcon: Icon(
                                    Icons.call_split,
                                    color: Colors.lightBlue,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.lightBlue),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                                items: genderItems,
                                isExpanded: true,
                              ));
                  }
                }),

            // Streams Dropdown

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

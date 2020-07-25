import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class userDataModel {
  var userId,userName, userEmail, userStream, userSemester, userPhoneNumber,
      userCollege, userGender, userJoinDate;

  String get getUserId => userId;
  String get getUserName => userName;
  String get getUserEmail => userEmail;
  String get getUserStream => userStream;
  String get getUserSemester => userSemester;
  String get getUserPhoneNumber => userPhoneNumber;
  String get getUserCollege => userCollege;
  String get getUserGender => userGender;
  String get getUserJoinDate => userJoinDate;

  userDataModel(
      this.userId,
      this.userName,
      this.userEmail,
      this.userStream,
      this.userSemester,
      this.userPhoneNumber,
      this.userCollege,
      this.userGender,
      this.userJoinDate);


  toJson() {
    return {
      "USERID": userId,
      "USERNAME": userName,
      "USEREMAIL": userEmail,
      "USERSTREAM": userStream,
      "USERSEMESTER": userSemester,
      "USERPHONENUMBER": userPhoneNumber,
      "USERCOLLEGE": userCollege,
      "USERGENDER": userGender,
      "USERJOINDATE": userJoinDate
    };
  }

  userDataModel.fromSnapshot(DataSnapshot dataSnapshot){
    userId = dataSnapshot.value['USERID'];
    userName = dataSnapshot.value['USERNAME'];
    userEmail = dataSnapshot.value['USEREMAIL'];
    userStream = dataSnapshot.value['USERSTREAM'];
    userSemester = dataSnapshot.value['USERSEMESTER'];
    userPhoneNumber = dataSnapshot.value['USERPHONENUMBER'];
    userCollege = dataSnapshot.value['USERCOLLEGE'];
    userGender = dataSnapshot.value['USERGENDER'];
    userJoinDate = dataSnapshot.value['USERJOINDATE'];
  }

}

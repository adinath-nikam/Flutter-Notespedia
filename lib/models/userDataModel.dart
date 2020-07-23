import 'package:flutter/material.dart';

class userDataModel {
  var userId,userName, userEmail, userStream, userSemester, userPhoneNumber,
      userCollege, userGender, userJoinDate;

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


}

import 'package:firebase_database/firebase_database.dart';

class scholarshipModel {
  String scName, scLastDate, scEligibility, scAward, scUrl, scImgUrl;

  scholarshipModel(
      {this.scName,
      this.scLastDate,
      this.scEligibility,
      this.scAward,
      this.scUrl,
      this.scImgUrl});
}

class internshipModel {
  String internshipName,
      internshipLastDate,
      internshipPlace,
      internshipAward,
      internshipUrl,
      internshipImgUrl,
      intershipDuration,
      internshipCompanyName;

  internshipModel(
      {this.internshipName,
      this.internshipLastDate,
      this.internshipPlace,
      this.internshipAward,
      this.internshipUrl,
      this.internshipImgUrl,
      this.intershipDuration,
      this.internshipCompanyName});
}

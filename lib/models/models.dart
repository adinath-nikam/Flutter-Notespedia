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

class CarouselData {
  String imgUrl, link;

  CarouselData(this.imgUrl, this.link);

  CarouselData.fromSnapshot(DataSnapshot dataSnapshot) {
    imgUrl = dataSnapshot.value['IMGURL'];
    link = dataSnapshot.value['LINK'];
  }
}

class projectDataModel {
  String projectTitle,
      projectDescription,
      projectImage,
      projectAuthor,
      projectCost,
      projectStream;

  projectDataModel(
      this.projectTitle,
      this.projectDescription,
      this.projectImage,
      this.projectAuthor,
      this.projectCost,
      this.projectStream);
}

class dropDownDataClass {
  String dropDownItem;

  dropDownDataClass(this.dropDownItem);
}

import 'package:firedart/firestore/models.dart';

class CourseModel {
  String? coursetime;
  int? courseid;
  int? classnumber;
  String? days;
  DocumentReference? doctorid;
  String? courseuid;
  String? coursename;
  String? piccourse;

  CourseModel(
      {this.coursetime,
      this.courseid,
      this.classnumber,
      this.days,
      this.doctorid,
      this.courseuid,
      this.coursename,
      this.piccourse});

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
        classnumber: map['classnumber'],
        days: map['days'],
        courseid: map['courseid'],
        coursetime: map['coursetime'],
        doctorid: map['doctorid'],
        courseuid: map['uid'],
        coursename: map['coursename'],
        piccourse: map['piccourse']);
  }
  Map<String, dynamic> toMap() {
    return {
      'classnumber': classnumber,
      'days': days,
      'courseid': courseid,
      'coursetime': coursetime,
      'doctorid': doctorid,
      'coursename': coursename,
      'piccourse': piccourse
    };
  }
}

import 'package:firedart/firedart.dart';

class StudentModel {
  String? studentuid;
  int? studentid;
  String? studentname;
  List<DocumentReference>? courses;
  String? attendence;
  int? fingerprintid;

  StudentModel(
      {this.studentid,
      this.studentname,
      this.courses,
      this.attendence,
      this.fingerprintid,
      this.studentuid});

  StudentModel.fromMap(Map<String, dynamic> map) {
    studentid = map['studentid'];
    studentname = map['studentname'];
    if (map['courses'] != null) {
      courses = List<DocumentReference>.from(map['courses']);
    }
    attendence = map['attendence'];
    fingerprintid = map['fingerprintid'];
    studentid = map['studentid'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentid'] = studentid;
    data['studentname'] = studentname;
    if (courses != null) {
      data['courses'] = courses;
    }
    if (attendence != null) {
      data['attendence'] = attendence;
    }
    data['fingerprintid'] = fingerprintid;
    return data;
  }
}

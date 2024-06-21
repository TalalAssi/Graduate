import 'package:firedart/firedart.dart';
import 'package:graduate/models/report.dart';

class AttendenceModel {
  List<Report>? report;
  DocumentReference? studentuid;

  AttendenceModel({this.report, this.studentuid});

  AttendenceModel.fromMap(Map<String, dynamic> map) {
    if (map['report'] != null) {
      report = <Report>[];
      map['report'].forEach((v) {
        report!.add(Report.fromMap(v));
      });
    }
    studentuid = map['studentuid'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (report != null) {
      data['report'] = report!.map((v) => v.toMap()).toList();
    }
    data['studentuid'] = studentuid;
    return data;
  }
}

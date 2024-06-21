import 'package:firedart/firedart.dart';

class Report {
  String? date;
  DocumentReference? courseuid;
  bool? attended;

  Report({this.date, this.courseuid, this.attended});

  Report.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    courseuid = map['courseuid'];
    attended = map['attended'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['courseuid'] = courseuid;
    data['attended'] = attended;
    return data;
  }
}

class DoctorModel {
  int? doctorid;
  String? doctorname;

  DoctorModel({
    this.doctorid,
    this.doctorname,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      doctorid: map['doctorid'],
      doctorname: map['doctorname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorid': doctorid,
      'doctorname': doctorname,
    };
  }
}

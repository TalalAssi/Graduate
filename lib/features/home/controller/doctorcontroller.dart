import 'package:firedart/firedart.dart';
import 'package:get/get.dart';
import 'package:graduate/models/course_model.dart';
import 'package:graduate/models/doctor_model.dart';
import 'package:localstorage/localstorage.dart';

class DoctorController extends GetxController {
  CollectionReference couresRef = Firestore.instance.collection("course");

  String? doctorUid = localStorage.getItem('doctor-uid');
  String? rule = localStorage.getItem('rule');

  List<CourseModel> courses = [];
  List<DoctorModel> doctors = [];
  bool isLoding = false;
  // bool isUploadDialogShow = false;

  // handleUploadDialog() {
  //   isUploadDialogShow = !isUploadDialogShow;
  //   update();
  // }

  // dynamic handleDoctorUid() async {
  //   doctors.clear();
  //   String doctorUidAfterSplit = doctorUid!.split("/")[2];
  //   final doctorRef = await Firestore.instance
  //       .collection("doctor")
  //       .document(doctorUidAfterSplit)
  //       .get();
  //   doctors.add(DoctorModel.fromMap(doctorRef.map));
  // }
  handleDoctorUid() {
    doctors.clear();
    String doctorUidAfterSplit = doctorUid!.split("/")[2];
    return doctorUidAfterSplit;
  }

  getDoctorName() {
    String? dName;
    for (var element in doctors) {
      dName = element.doctorname!;
    }
    return dName;
  }

  @override
  void onInit() async {
    isLoding = true;
    final courseResponse = await couresRef
        .where("doctorid", isEqualTo: Firestore.instance.document(doctorUid!))
        .get();
    // await handleDoctorUid();
    // getDoctorName();

    final doctorRef = await Firestore.instance
        .collection("doctor")
        .document(handleDoctorUid())
        .get();
    doctors.add(DoctorModel.fromMap(doctorRef.map));
    getDoctorName();

    courses.addAll(
      courseResponse.map(
        (course) {
          {
            Map<String, dynamic> data = {
              'doctorid': course["doctorid"],
              'coursetime': course["coursetime"],
              'courseid': course["courseid"],
              'classnumber': course["classnumber"],
              'days': course["days"],
              'uid': course.path,
              'coursename': course['coursename'],
              'piccourse': course['piccourse']
            };
            return CourseModel.fromMap(data);
          }
        },
      ),
    );
    isLoding = false;
    update();
    super.onInit();
  }
}

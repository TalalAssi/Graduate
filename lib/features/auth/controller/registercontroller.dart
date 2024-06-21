import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate/features/auth/widget/custommaterialbutton.dart';
import 'package:graduate/models/attendence_model.dart';
import 'package:graduate/models/course_model.dart';
import 'package:graduate/models/doctor_model.dart';
import 'package:graduate/models/student_model.dart';

class RegisterController extends GetxController {
  CollectionReference couresRef = Firestore.instance.collection("course");
  CollectionReference doctorRef = Firestore.instance.collection("doctor");
  CollectionReference studentRef = Firestore.instance.collection("student");
  CollectionReference attendenceRef =
      Firestore.instance.collection("attendence");

  late final TextEditingController idStudentController;

  late final TextEditingController idCouresController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  bool studentIdState = false;
  bool isLoding = false;
  List<Map<String, dynamic>> classInfo = [{}];
  List<CourseModel> courses = [];
  int chosedClass = 0;
  List<DoctorModel> doctors = [];
  List<StudentModel> studentModels = [];
  // List<AttendenceModel> attendenceModel = [];
  List<Map<String, dynamic>> handleattendence = [{}];

  getCourse() async {
    classInfo.clear();
    courses.clear();
    chosedClass = 0;
    doctors.clear();
    isLoding = true;
    try {
      update();
      studentIdState = false;
      if (formKey.currentState!.validate()) {
        final response = await couresRef
            .where("courseid", isEqualTo: int.parse(idCouresController.text))
            .get();

        if (response.isNotEmpty) {
          for (var element in response) {
            final doctorResponse =
                await doctorRef.document(element["doctorid"].id).get();
            Map<String, dynamic> data = {
              'doctorid': element["doctorid"],
              'coursetime': element["coursetime"],
              'courseid': element["courseid"],
              'classnumber': element["classnumber"],
              'days': element["days"],
              'uid': element.path,
              'coursename': element['coursename'],
              'piccourse': element['piccourse']
            };
            courses.add(CourseModel.fromMap(data));
            classInfo.add({
              'classnumber': element['classnumber'],
              'doctorname': doctorResponse.map['doctorname']
            });
          }
          isLoding = false;
          studentIdState = true;
          update();
        } else {
          isLoding = false;
          studentIdState = false;
          update();
          Get.defaultDialog(
              backgroundColor: Colors.black,
              title: "Wrong Course ID !!",
              titleStyle: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              middleText: "This Course Does Not Exist , Try Again",
              middleTextStyle: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              actions: [
                CustomMaterialButton(
                    height: 50,
                    width: 80,
                    textbutton: "back",
                    onpress: () {
                      Get.back();
                    }),
              ]);
        }
      } else {
        isLoding = false;
        studentIdState = false;
        update();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  changeSelected(int? value) {
    chosedClass = value!;
    update();
  }

  getDaysOfCourse() {
    final result = courses.firstWhere((element) =>
        element.classnumber == classInfo[chosedClass]['classnumber']);

    return result.days;
  }

  getTimeOfCourse() {
    final result = courses.firstWhere((element) =>
        element.classnumber == classInfo[chosedClass]['classnumber']);

    return result.coursetime;
  }

  registerStudentToCourse() async {
    handleattendence.clear();
    if (formKey1.currentState!.validate()) {
      bool isCourseExist = false;
      final courseModelSelcted = courses.firstWhere((element) =>
          element.classnumber == classInfo[chosedClass]['classnumber']);
      final response = await studentRef
          .where("studentid", isEqualTo: int.parse(idStudentController.text))
          .get();

      Map<String, dynamic> map = {
        'studentid': response[0]['studentid'],
        'studentname': response[0]['studentname'],
        'attendence': response[0]['attendence'].path,
        'courses': response[0]['courses'],
        'studentuid': response[0]['studentuid']
      };

      final StudentModel studentModel = StudentModel.fromMap(map);
      map.clear();
      for (var i = 0; i < courses.length; i++) {
        for (var j = 0; j < studentModel.courses!.length; j++) {
          if (courses[i].courseuid!.split("/")[2] ==
              studentModel.courses![j].id) {
            if (courses[i].courseid == courseModelSelcted.courseid) {
              isCourseExist = true;
              break;
            }
          }
        }
      }

      if (isCourseExist == false) {
        final rsponseAthorStudent = await studentRef
            .where("courses",
                arrayContains:
                    Firestore.instance.document(courseModelSelcted.courseuid!))
            .get();
        for (var i = 0; i < rsponseAthorStudent.length; i++) {
          Map<String, dynamic> map = {
            'studentid': rsponseAthorStudent[i]['studentid'],
            'studentname': rsponseAthorStudent[i]['studentname'],
            'attendence': rsponseAthorStudent[i]['attendence'].path,
            'courses': rsponseAthorStudent[i]['courses'],
            'studentuid': rsponseAthorStudent[i]['studentuid']
          };
          studentModels.add(StudentModel.fromMap(map));
        }
        bool isbreak = false;
        for (var i = 0; i < rsponseAthorStudent.length; i++) {
          if (isbreak == true) {
            break;
          }
          for (var j = studentModels[i].courses!.length - 1; j > 0; j--) {
            if (Firestore.instance.document(courseModelSelcted.courseuid!) ==
                studentModels[i].courses![j]) {
              isbreak = true;
              final attendence = await Firestore.instance
                  .collection('attendence')
                  .document(studentModels[i].attendence!.split("/")[1])
                  .get();
              for (var i = 0; i < attendence['report'].length; i++) {
                if (attendence['report'][i]['courseuid'] ==
                    Firestore.instance
                        .document(courseModelSelcted.courseuid!)) {
                  handleattendence.add({
                    'attended': true,
                    'courseuid': attendence['report'][i]['courseuid'],
                    'date': attendence['report'][i]['date']
                  });
                }
              }

              break;
            }
          }
        }
        if (isbreak == true) {
          final response = await Firestore.instance
              .collection('attendence')
              .document(studentModel.attendence!.split("/")[1])
              .get();
          AttendenceModel attendenceModel =
              AttendenceModel.fromMap(response.map);
          for (var i = 0; i < attendenceModel.report!.length; i++) {
            handleattendence.add({
              'attended': attendenceModel.report![i].attended,
              'courseuid': attendenceModel.report![i].courseuid,
              'date': attendenceModel.report![i].date
            });
          }
          // ignore: unused_local_variable
          final responseForUpdate = await attendenceRef
              .document(studentModel.attendence!.split("/")[1])
              .update({'report': handleattendence});
        }
        List updatedStudentCourses = [
          Firestore.instance.document(courseModelSelcted.courseuid!)
        ];
        updatedStudentCourses.addAll(response[0].map['courses']);

        // ignore: unused_local_variable
        final responseUpdate = await studentRef
            .document(response[0].id)
            .update({'courses': updatedStudentCourses});

        Get.snackbar(
          colorText: Colors.white,
          'successful',
          'The student has been registered successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.defaultDialog(
            backgroundColor: Colors.black,
            title: "Course Already Exist !!",
            titleStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "Montserrat",
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400),
            middleText: "The student is already registered in this course",
            middleTextStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "Montserrat",
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400),
            actions: [
              CustomMaterialButton(
                  height: 50,
                  width: 80,
                  textbutton: "back",
                  onpress: () {
                    Get.back();
                  }),
            ]);
      }
    }
  }

  @override
  void onInit() {
    idStudentController = TextEditingController();
    idCouresController = TextEditingController();

    super.onInit();
  }
}

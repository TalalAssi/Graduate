import 'dart:io';

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:get/get.dart';
import 'package:graduate/models/attendence_model.dart';
import 'package:graduate/models/student_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendenceController extends GetxController {
  late String courseUid;
  CollectionReference studentRef = Firestore.instance.collection("student");
  CollectionReference attendeceRef =
      Firestore.instance.collection("attendence");
  List<StudentModel> studentList = [];
  List<String> documentReference = [];
  List<AttendenceModel> attendenceList = [];
  ///////////////////////////////////////////
  List<String> studebtsName = [];
  List<String> dateList = [];
  List<List<bool>> atList = [];
  List<int> studentid = [];
  int currentDataPage = 0;
  int fromDate = 0;
  int toDate = 5;
  bool isDateNext = true;
  var hoverIndex = (-1).obs;
  List<String> activePageDateItems = [];
  List<List<bool>> activePageAtItems = [];
  ///////////////////////////////////////////
  bool isloding = false;
  void setHoverIndex(int index) {
    hoverIndex.value = index;
  }

  handleNextPagination() {
    if (isDateNext) {
      activePageAtItems.clear();
      activePageDateItems.clear();

      if (dateList.length <= ((currentDataPage + 1) * 5)) {
        for (int j = 0; j < atList.length; j++) {
          activePageAtItems.add([]);
          for (int i = toDate; i < dateList.length; i++) {
            activePageAtItems[j].add(atList[j][i]);
            if (j == 0) {
              activePageDateItems.add(dateList[i]);
            }
          }
        }
        fromDate = toDate;
        toDate = dateList.length;
        isDateNext = false;
        currentDataPage++;
      } else {
        fromDate = toDate;
        toDate = toDate + 5;
        for (int j = 0; j < atList.length; j++) {
          activePageAtItems.add([]);
          for (int i = fromDate; i < toDate; i++) {
            activePageAtItems[j].add(atList[j][i]);
            if (j == 0) {
              activePageDateItems.add(dateList[i]);
            }
          }
        }
        isDateNext = true;
        currentDataPage++;
      }
    }

    update();
  }

  handlePreviousPagination() {
    if (currentDataPage > 1) {
      fromDate = fromDate - 5;
      toDate = toDate - activePageAtItems[0].length;

      activePageAtItems.clear();
      activePageDateItems.clear();
      for (int j = 0; j < atList.length; j++) {
        activePageAtItems.add([]);
        for (int i = fromDate; i < toDate; i++) {
          activePageAtItems[j].add(atList[j][i]);
          if (j == 0) {
            activePageDateItems.add(dateList[i]);
          }
        }
      }
      currentDataPage--;
      isDateNext = true;
      update();
    }
  }

  getStudentInfo(String val) async {
    isloding = true;
    update();
    final response = await studentRef
        .where("courses", arrayContains: Firestore.instance.document(val))
        .get();
    for (var element in response) {
      Map<String, dynamic> data = {
        'uid': element.path,
        'studentid': element["studentid"],
        'studentname': element["studentname"],
        'courses': element["courses"],
        'attendence': element["attendence"].id.toString(),
        'fingerprintid': element["fingerprintid"]
      };
      studentList.add(StudentModel.fromMap(data));
    }
    for (int i = 0; i < studentList.length; i++) {
      studebtsName.add(studentList[i].studentname!);
      studentid.add(studentList[i].studentid!);
    }
    for (var element in studentList) {
      documentReference.add(element.attendence!.toString());
    }

    for (var element in documentReference) {
      var responseAttendence = await attendeceRef.document(element).get();
      attendenceList.add(AttendenceModel.fromMap(responseAttendence.map));
    }

    for (int i = 0; i < attendenceList.length; i++) {
      atList.add([]);
      for (int j = 0; j < attendenceList[i].report!.length; j++) {
        if (i == 0 &&
            (attendenceList[i].report![j].courseuid!.id ==
                courseUid.split("/")[2])) {
          dateList.add(attendenceList[i].report![j].date!);
        }
        if (attendenceList[i].report![j].courseuid!.id ==
            courseUid.split("/")[2]) {
          atList[i].add(attendenceList[i].report![j].attended!);
        }
      }
    }
    isloding = false;
    update();
  }

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    for (var i = 1; i < studebtsName.length + 1; i++) {
      sheet.getRangeByName('A${i + 1}').setText(studebtsName[i - 1]);
      for (var j = 1; j < atList[i - 1].length + 1; j++) {
        sheet
            .getRangeByIndex(2 + (i - 1), j + 1)
            .setText(atList[i - 1][j - 1].toString());
      }
    }
    for (var i = 1; i < dateList.length + 1; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(dateList[i - 1]);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path\\Output.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    await OpenFile.open(fileName);
  }

  void launchOutlookComposeEmail(int i) async {
    final course = await Firestore.instance.document(courseUid).get();
    String message =
        "Please note that you have exceeded the permissible limit for absences and necessary measures will be taken";
    final url = Uri.parse(
      'https://outlook.live.com/owa/?path=/mail/action/compose'
      '&to=${studentid[i]}@st.ahu.edu.jo'
      '&subject=warning from university'
      '&body=Name : ${studebtsName[i]}\n'
      'course : ${Uri.encodeComponent(course.map['coursename'])}\n'
      'massage : $message',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar(
        'Error',
        'Could not open a web browser to compose email.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() async {
    courseUid = Get.arguments["course-uid"];
    await getStudentInfo(courseUid);
    if (dateList.length < 5) {
      activePageAtItems = atList;
      activePageDateItems = dateList;
      isDateNext = false;
      currentDataPage = 1;
    } else {
      for (int j = 0; j < atList.length; j++) {
        activePageAtItems.add([]);
        for (int i = fromDate; i < toDate; i++) {
          activePageAtItems[j].add(atList[j][i]);
          if (j == 0) {
            activePageDateItems.add(dateList[i]);
          }
        }
      }

      currentDataPage = 1;

      isDateNext = true;
    }

    super.onInit();
  }
}

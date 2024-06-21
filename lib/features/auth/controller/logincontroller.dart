import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate/features/auth/widget/custommaterialbutton.dart';
import 'package:graduate/routes.dart';
import 'package:localstorage/localstorage.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController idController;
  late final TextEditingController passwordController;
  CollectionReference doctorRef = Firestore.instance.collection("doctor");
  CollectionReference userRef = Firestore.instance.collection("users");
  bool state = true;
  getLoginInfo() async {
    if (formKey.currentState!.validate()) {
      final responseUser = await userRef
          .where("id", isEqualTo: int.parse(idController.text)) ////
          .get();

      if (responseUser.isNotEmpty) {
        localStorage.setItem('rule', responseUser[0].map['rule']);
        if (responseUser[0].map['password'] == passwordController.text) {
          if (responseUser[0].map['rule'] == 'doctor') {
            final responseDoctor = await doctorRef
                .where("doctorid", isEqualTo: responseUser[0].map['id']) ////
                .get();
            String uid = responseDoctor[0].path;
            localStorage.setItem('doctor-uid', uid);
            Get.offAllNamed(Routes.screen3);
          } else {
            Get.offAllNamed(Routes.screen2);
          }
        } else {
          Get.defaultDialog(
            backgroundColor: Colors.black,
            title: "Wrong Password !!",
            titleStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "Montserrat",
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400),
            middleText: "Password is Wrong ,",
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
                },
              ),
            ],
          );
        }
      } else {
        Get.defaultDialog(
            backgroundColor: Colors.black,
            title: "Wrong ID !!",
            titleStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: "Montserrat",
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400),
            middleText: "The User Does Not Exist , Invalid ID",
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

  stateShowPassword() {
    state = !state;
    update();
  }

  @override
  void onInit() {
    idController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate/component/primarycolor.dart';
import 'package:graduate/features/auth/controller/registercontroller.dart';
import 'package:graduate/features/auth/widget/blackcontainer.dart';
import 'package:graduate/features/auth/widget/custom_containerdesign.dart';
import 'package:graduate/features/auth/widget/custommaterialbutton.dart';
import 'package:graduate/features/auth/widget/customtextfelid.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());

    return GetBuilder<RegisterController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.transparent,
        body: controller.isLoding
            ? Center(child: Lottie.asset('assests/json/ani.json'))
            : Container(
                color: primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, left: 30),
                        child: BlackContainer(
                          marginForRight: 0,
                          height: 700,
                          width: 700,
                          list: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              width: 130,
                              height: 150,
                              child: Image.asset(
                                "assests/images/logo.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 250,
                                    child: Form(
                                      key: controller.formKey,
                                      child: CustomTextFelid(
                                        inputType: TextInputType.number,
                                        isDigits: true,
                                        text: "Course ID",
                                        icon: const Icon(Icons.numbers_rounded),
                                        scuretext: false,
                                        controller:
                                            controller.idCouresController,
                                        validatorCheck: (value) {
                                          if (value == "") {
                                            return "This Filled Required";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: CustomMaterialButton(
                                    marginFromTop: 0,
                                    width: 250,
                                    height: 58,
                                    textbutton: "Bring Data",
                                    onpress: () async {
                                      await controller.getCourse();
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 0),
                                    child: DropdownMenu(
                                      label: Text(controller.classInfo.isEmpty
                                          ? "empty"
                                          : controller
                                              .classInfo[controller.chosedClass]
                                                  ["classnumber"]
                                              .toString()),
                                      requestFocusOnTap: false,
                                      width: 300,
                                      enableSearch: false,
                                      textStyle:
                                          const TextStyle(color: Colors.white),
                                      enabled: controller.courses.isEmpty
                                          ? false
                                          : true,
                                      dropdownMenuEntries:
                                          controller.classInfo.map((item) {
                                        return DropdownMenuEntry(
                                            value: controller.classInfo
                                                .indexOf(item),
                                            label: "${item["classnumber"]}");
                                      }).toList(),
                                      onSelected: (value) {
                                        controller.changeSelected(value);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 250,
                                    child: CoustmContainerDesign(
                                      text:
                                          "${controller.courses.isEmpty ? "Days" : controller.getDaysOfCourse()}",
                                      icon: Icons.calendar_today_rounded,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                      width: 250,
                                      child: CoustmContainerDesign(
                                          icon: Icons.abc_rounded,
                                          text:
                                              "${controller.courses.isEmpty ? "Doctor Name" : controller.classInfo[controller.chosedClass]['doctorname']}")),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: SizedBox(
                                      width: 250,
                                      child: CoustmContainerDesign(
                                        icon: Icons.calendar_today_rounded,
                                        text:
                                            "${controller.courses.isEmpty ? "Times" : controller.getTimeOfCourse()}",
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 150),
                                    width: 300,
                                    child: Form(
                                      key: controller.formKey1,
                                      child: CustomTextFelid(
                                        inputType: TextInputType.number,
                                        isDigits: true,
                                        enableFeild: controller.studentIdState,
                                        text: "Student ID",
                                        icon: const Icon(Icons.numbers),
                                        scuretext: false,
                                        controller:
                                            controller.idStudentController,
                                        validatorCheck: (value) {
                                          if (value == "") {
                                            return "This Filled Required";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(
                                    width: 170,
                                  ),
                                ),
                              ],
                            ),
                            CustomMaterialButton(
                              textbutton: "Register",
                              onpress: () async {
                                await controller.registerStudentToCourse();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: SizedBox(
                                  width: 200,
                                  height: 190,
                                  child: Image.asset(
                                    "assests/images/AHUlogo.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 450,
                                width: 370,
                                child: Image.asset(
                                  "assests/images/welcome image.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

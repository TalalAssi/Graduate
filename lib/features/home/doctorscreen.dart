import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate/component/primarycolor.dart';
import 'package:graduate/features/auth/loginscreen.dart';
import 'package:graduate/features/auth/widget/blackcontainer.dart';
import 'package:graduate/features/auth/widget/custommaterialbutton.dart';
import 'package:graduate/features/auth/widget/customtext.dart';
import 'package:graduate/features/home/attendencescreen.dart';
import 'package:graduate/features/home/controller/doctorcontroller.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;

    Get.put(DoctorController());
    return GetBuilder<DoctorController>(
      builder: (controller) => Scaffold(
        body: Scaffold(
          body: Container(
            margin: const EdgeInsets.only(top: 20),
            height: screenHight,
            color: primary,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: BlackContainer(
                    marginForTop: 0,
                    height: screenHight,
                    width: 300,
                    list: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        height: 250,
                        width: 250,
                        child: Image.asset(
                          "assests/images/welcome-doctor.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Center(
                        child: CustomText(
                            fontsize: 16,
                            string:
                                "Welcome Doctor ${controller.getDoctorName()}"),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      CustomMaterialButton(
                          textbutton: "log Out",
                          onpress: () {
                            Get.off(const LoginScreen());
                          })
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(children: [
                    Expanded(
                      flex: 5,
                      child: controller.isLoding
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 15, left: 15),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            MediaQuery.of(context).size.width <=
                                                    500
                                                ? 2
                                                : 3,
                                        mainAxisSpacing: 10.5,
                                        crossAxisSpacing: 10.5),
                                itemCount: controller.courses.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => const AttendenceScreen(),
                                          arguments: {
                                            "course-uid": controller
                                                .courses[index].courseuid!
                                          });
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: const Color(0xFF141414),
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 9,
                                                  spreadRadius: 2)
                                            ]),
                                        height: 250,
                                        width: 250,
                                        child: Column(children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              child: Image.asset(
                                                controller
                                                    .courses[index].piccourse!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: CustomText(
                                                fontsize: 16,
                                                string:
                                                    "${controller.courses[index].coursename}"),
                                          )
                                        ])),
                                  );
                                },
                              ),
                            ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

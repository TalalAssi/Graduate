import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate/component/primarycolor.dart';
import 'package:graduate/features/home/controller/attendencecontroller.dart';

class AttendenceScreen extends StatelessWidget {
  const AttendenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AttendenceController());
    return GetBuilder<AttendenceController>(
      builder: (controller) => Scaffold(
        appBar: controller.isloding
            ? AppBar()
            : AppBar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                title: const Text(
                  "i-Attend",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                elevation: 5.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                actions: [
                  InkWell(
                    onTap: () async {
                      await controller.createExcel();
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assests/images/Microsoft Excel 2019.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
        body: controller.isloding
            ? Center(
                child: CircularProgressIndicator(color: Colors.amber),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                color: primary,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(right: 64),
                                child: const Text("StudentID")),
                            Expanded(
                              flex: 12,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: 15),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.activePageDateItems.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 30),
                                    height: 20,
                                    child: Text(
                                        controller.activePageDateItems[index]),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            color: Colors.black,
                            height: 1,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.studebtsName.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 900,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 105,
                                      child: MouseRegion(
                                        onEnter: (_) {
                                          controller.setHoverIndex(index);
                                        },
                                        onExit: (_) {
                                          controller.setHoverIndex(-1);
                                        },
                                        child: Obx(
                                          () => InkWell(
                                            onTap: () {
                                              controller
                                                  .launchOutlookComposeEmail(
                                                      index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      spreadRadius: 7,
                                                      blurStyle:
                                                          BlurStyle.outer,
                                                      color: controller
                                                                  .hoverIndex
                                                                  .value ==
                                                              index
                                                          ? Color.fromARGB(141,
                                                              224, 224, 224)
                                                          : Colors.transparent,
                                                    )
                                                  ]),
                                              child: Text(
                                                "${controller.studentid[index]}",
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 20,
                                      width: 250,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Container(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 9.4),
                                          ),
                                        ),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .activePageAtItems[index].length,
                                        itemBuilder: (context, subIndex) {
                                          return SizedBox(
                                            width: 80,
                                            height: 20,
                                            child: Icon(
                                                controller.activePageAtItems[
                                                            index][subIndex] ==
                                                        false
                                                    ? Icons.close
                                                    : Icons.check),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              child: const Text("Previous"),
                              onPressed: () {
                                controller.handlePreviousPagination();
                                // controller.getStudentInfo(courseUid);
                              },
                            ),
                            MaterialButton(
                              child: const Text("Next"),
                              onPressed: () {
                                controller.handleNextPagination();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

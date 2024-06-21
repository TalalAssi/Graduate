import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate/component/primarycolor.dart';
import 'package:graduate/features/auth/controller/logincontroller.dart';
import 'package:graduate/features/auth/widget/blackcontainer.dart';
import 'package:graduate/features/auth/widget/custommaterialbutton.dart';
import 'package:graduate/features/auth/widget/customtext.dart';
import 'package:graduate/features/auth/widget/customtextfelid.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
        body: Container(
          color: primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 58, top: 30, left: 30),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: 250,
                            height: 250,
                            child: Image.asset(
                              "assests/images/AHUlogo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Alhussein Bin Talal Unversity",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            height: 400,
                            width: 250,
                            child: Image.asset(
                              "assests/images/student.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(right: 50),
                  child: Form(
                    key: controller.formKey,
                    child: BlackContainer(
                      height: 600,
                      width: 375,
                      list: [
                        SizedBox(
                          width: 140,
                          height: 191,
                          child: Image.asset(
                            "assests/images/logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: CustomTextFelid(
                            inputType: TextInputType.number,
                            isDigits: true,
                            controller: controller.idController,
                            text: "Enter your ID",
                            icon: const Icon(Icons.person),
                            scuretext: false,
                            validatorCheck: (value) {
                              if (value == "") {
                                return "This Filled Required";
                              }
                              return null;
                            },
                          ),
                        ),
                        CustomTextFelid(
                          controller: controller.passwordController,
                          text: "Enter your Password",
                          icon: const Icon(Icons.password),
                          scuretext: controller.state,
                          validatorCheck: (value) {
                            if (value == "") {
                              return "This Filled Required";
                            }
                            return null;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15, left: 175),
                          child: InkWell(
                            child: const CustomText(
                                fontsize: 12, string: "Show Password"),
                            onTap: () {
                              controller.stateShowPassword();
                            },
                          ),
                        ),
                        CustomMaterialButton(
                          textbutton: "login",
                          onpress: () {
                            controller.getLoginInfo();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:graduate/features/auth/loginscreen.dart';
import 'package:graduate/features/auth/registerscreen.dart';
import 'package:graduate/features/home/doctorscreen.dart';

class Routes {
  static String screen1 = '/';
  static String screen2 = '/Rs';
  static String screen3 = '/Ds';
}

final getPages = [
  GetPage(
    name: Routes.screen1,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: Routes.screen2,
    page: () => const RegisterScreen(),
  ),
  GetPage(
    name: Routes.screen3,
    page: () => const DoctorScreen(),
  ),
];

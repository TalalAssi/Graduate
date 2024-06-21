import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate/routes.dart';
import 'package:localstorage/localstorage.dart';

const apiKey = "AIzaSyDiRsZzagUWNr4XVN74mGKMyoXErGqVVJM";
const projectId = "gaduate-fc648";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firestore.initialize(projectId);
  await initLocalStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "Montserrat"),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.screen1,
      getPages: getPages,
    );
  }
}

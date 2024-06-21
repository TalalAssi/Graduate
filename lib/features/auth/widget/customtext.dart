import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.fontsize, required this.string});
  final double fontsize;
  final String string;
  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: "Montserrat",
          fontSize: fontsize,
          color: Colors.white,
          fontWeight: FontWeight.w400),
    );
  }
}

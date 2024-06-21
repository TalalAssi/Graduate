import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton(
      {super.key,
      required this.textbutton,
      required this.onpress,
      this.height = 60,
      this.width = 255,
      this.radius = 8,
      this.marginFromTop = 20});
  final String textbutton;
  final VoidCallback onpress;
  final double height;
  final double width;
  final double radius;
  final double marginFromTop;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginFromTop),
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(238, 255, 200, 0),
            Color.fromARGB(101, 255, 200, 0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: MaterialButton(
        onPressed: onpress,
        child: Text(
          textbutton,
          style: const TextStyle(color: Colors.white, fontFamily: "Montserrat"),
        ),
      ),
    );
  }
}

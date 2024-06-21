import 'package:flutter/material.dart';

class BlackContainer extends StatelessWidget {
  const BlackContainer({
    super.key,
    required this.height,
    required this.width,
    required this.list,
    this.marginForTop = 45,
    this.marginForLeft = 0,
    this.paddingHorizontal = 15,
    this.paddingVertical = 8,
    this.blurRadius = 15.3,
    this.spreadRadius = 2,
    this.marginForRight = 0,
  });
  final double height;
  final double width;
  final List<Widget> list;
  final double marginForTop;
  final double marginForLeft;
  final double marginForRight;

  final double paddingHorizontal;
  final double paddingVertical;
  final double blurRadius;
  final double spreadRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginForTop, left: marginForLeft),
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: const Color(0xFF141414),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical, child: Column(children: list)),
      ),
    );
  }
}

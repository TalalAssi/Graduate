import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduate/features/auth/widget/customtext.dart';

class CoustmContainerDesign extends StatelessWidget {
  const CoustmContainerDesign(
      {super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          strokeAlign: BorderSide.strokeAlignInside,
          width: .9,
          color: const Color(0xFF9E9E9E),
        ),
        color: const Color.fromARGB(255, 20, 20, 20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Icon(
              icon,
              color: const Color(0xFF9E9E9E),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(flex: 4, child: CustomText(fontsize: 16, string: text))
        ],
      ),
    );
  }
}

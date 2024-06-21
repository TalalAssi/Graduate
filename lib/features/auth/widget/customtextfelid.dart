import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFelid extends StatelessWidget {
  const CustomTextFelid({
    super.key,
    required this.text,
    required this.icon,
    required this.scuretext,
    required this.controller,
    required this.validatorCheck,
    this.enableFeild = true,
    this.inputType = TextInputType.none,
    this.isDigits = false,
  });
  final String text;
  final Icon icon;
  final bool scuretext;
  final TextEditingController controller;
  final String? Function(String?)? validatorCheck;
  final bool enableFeild;
  final TextInputType inputType;
  final bool isDigits;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        isDigits
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter
      ],
      keyboardType: inputType,
      onChanged: (value) {},
      validator: validatorCheck,
      controller: controller,
      obscureText: scuretext,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabled: enableFeild,
        errorStyle: const TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Montserrat",
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        labelText: text,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: icon,
        prefixIconColor: Colors.grey[500],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}

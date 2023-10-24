import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    this.controller,
    required this.hintText,
    required this.disableOrEnable,
    required this.labelText,
    required this.borderColor,
    required this.filled,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final bool disableOrEnable;
  final int borderColor;
  final bool filled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFFFFFFFF)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(borderColor)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.blueAccent),
          ),
          enabled: disableOrEnable,
          filled: filled,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.white,) : null,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.white,) : null, // Use the provided prefix icon
          hintText: hintText,
          labelText: labelText,
          fillColor: Color(0xffececec),
        ),
        style: TextStyle(color: Colors.black),
        maxLines: 1000,
        minLines: 1,
      ),
    );
  }
}

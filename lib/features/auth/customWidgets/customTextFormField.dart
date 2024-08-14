import 'package:flutter/material.dart';
import '../../../utilities/consts.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, this.prefixIcon, this.keyboardType, this.hintText, this.hintTextDirection, this.textDirection, this.controller, this.initValue, this.onChanged, this.validator});

  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? hintText;
  final TextDirection? hintTextDirection ;
  final TextDirection? textDirection;
  final TextEditingController ? controller;
  final String? initValue ;
final Function(String)? onChanged;
final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      onChanged: onChanged,
      initialValue: initValue,
      controller:controller ,
      textDirection: textDirection,

      style: TextStyle(fontSize: 18),
      cursorColor: primaryColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintTextDirection: hintTextDirection,


          hintStyle: TextStyle(fontSize: 16),
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }
}

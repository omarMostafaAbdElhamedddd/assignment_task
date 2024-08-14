import 'package:flutter/material.dart';
import '../../../utilities/consts.dart';
import 'customText.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.text , this.borderRadius=8});

  final Function()? onTap;
  final String text;
  final double borderRadius ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
          child: CustomText(
            text: text,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

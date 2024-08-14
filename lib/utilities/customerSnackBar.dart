import 'package:flutter/material.dart';

import '../features/auth/customWidgets/customText.dart';

class MySanckBar {
  static snackBar(String message,var scaffoldMessenger){
    scaffoldMessenger.currentState!.hideCurrentSnackBar();
    scaffoldMessenger.currentState!.showSnackBar( SnackBar(
        backgroundColor: Colors.brown,
        behavior: SnackBarBehavior.floating,
        content: CustomText(text: message , color: Colors.white,fontSize: 16,)));

  }

}
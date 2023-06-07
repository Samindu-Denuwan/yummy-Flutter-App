
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/widgets/big_text.dart';

void showCustomSnackBar(String message, {bool isError = true, String title = "Error", IconData icon = Icons.error}){
  Get.snackbar(title, message,
      titleText: BigText(text: title, color: Colors.white, size: 14,),
      messageText: BigText(text: message, color: Colors.white, size: 11,),
      icon: Icon(icon, size: 30.sp, color: Colors.white30,),
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w));

}
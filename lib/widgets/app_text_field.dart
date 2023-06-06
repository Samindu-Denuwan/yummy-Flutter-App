import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final TextInputType inputType;
  bool isPassword;
   AppTextField({Key? key,
    this.isPassword = false,
    required this.textController,
    required this.hintText,
    required this.icon,
     required this.inputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.w),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        keyboardType: inputType,
        minLines: 1,
        obscureText: isPassword,
        style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black87,
            fontWeight: FontWeight.w300
        ),
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w200
          ),
          prefixIcon:  Icon(icon, color: AppColors.yellowColor,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.w),
            borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white
            ),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.w),
            borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white
            ),
          ),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.w),

          ),
        ),

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class BtnCustom extends StatelessWidget {
  final BigText bigText;
  final Color color;
  final EdgeInsets margin;
  const BtnCustom({Key? key,  required this.color, required this.bigText, required this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 150.w,
      height: 60.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.w),
          color: color
      ),
      child: Center(
          child: bigText,),
    );
  }
}



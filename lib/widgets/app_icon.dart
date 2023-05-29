

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon extends StatelessWidget {

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
   AppIcon({Key? key,
    required this.icon, this.backgroundColor =  const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54), this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: backgroundColor,

      ),
      child: Icon(icon, color: iconColor,size: 16.sp,),
    );
  }
}

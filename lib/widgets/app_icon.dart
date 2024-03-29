

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon extends StatelessWidget {

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
   AppIcon({Key? key,
    required this.icon, this.backgroundColor =  const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54), this.size = 40,
     this.iconSize = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.w),
        color: backgroundColor,

      ),
      child: Icon(icon, color: iconColor,size: iconSize.sp,),
    );
  }
}

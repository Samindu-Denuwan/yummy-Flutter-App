import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  FontWeight fontWeight;
  SmallText({Key? key,
    required this.text,
    this.color = const Color(0xFFccc7c5),
    this.size = 12,
    this.fontWeight = FontWeight.normal,
    this.height= 1.2,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size.sp,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: fontWeight,
        height: height.sp
      ),
    );
  }
}

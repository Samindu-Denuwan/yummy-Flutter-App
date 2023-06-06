import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  FontWeight fontWeight;
  TextOverflow overflow;
   BigText({Key? key,
    required this.text,
     this.color = const Color(0xFF332d2b),
     this.size = 18,
     this.fontWeight = FontWeight.w500,
     this.overflow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontSize: size.sp,
        color: color,
        fontFamily: 'Poppins',
        fontWeight: fontWeight
      ),
    );
  }
}

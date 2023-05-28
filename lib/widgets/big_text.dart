import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  TextOverflow overflow;
   BigText({Key? key,
    required this.text,
     this.color = const Color(0xFF332d2b),
     this.size = 20,
     this.overflow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500
      ),
    );
  }
}

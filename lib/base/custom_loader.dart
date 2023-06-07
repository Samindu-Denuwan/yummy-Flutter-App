import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200.h,
        width: 200.w,
        child: Lottie.network("https://assets6.lottiefiles.com/packages/lf20_L6fWWq.json",
        fit: BoxFit.cover,

        ),

      ),
    );
  }
}

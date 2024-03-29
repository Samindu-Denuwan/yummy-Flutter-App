import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class CustomBtn extends StatelessWidget {
  final BigText bigText;
  final VoidCallback? onPressed;
  final bool transparent;
  final  EdgeInsets? margin;
  final double? height;
  final double? width;
  final double radius;
  final IconData? icon;
  const CustomBtn({Key? key,
    this.onPressed,
    this.transparent= false,
    this.margin ,
    this.height = 50,
    this.width = 150,
    this.radius = 5,
    this.icon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final ButtonStyle buttonStyle= TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor: transparent
          ?Colors.transparent: AppColors.mainColor,
      minimumSize: Size(
          width!.w,
          height!.h),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.w),

      )

    );
    return Center(
      child: SizedBox(
        width: width!.w,
        height: height!.h,
        child: TextButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!=null? Padding(
                    padding: EdgeInsets.only(right: 10.w),
                child: Icon(icon, color: transparent? AppColors.mainColor: Colors.white,),
                ): SizedBox(width: 5.w,),
                bigText,
              ],
            )),

      ),
    );
  }
}


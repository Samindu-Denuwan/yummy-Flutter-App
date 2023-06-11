import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class CustomBtn extends StatelessWidget {
  final BigText bigText;
  final VoidCallbackAction? onPressed;
  final bool transparent;
  final  EdgeInsets? margin;
  final double? height;
  final double? width;
  final double radius;
  final IconData? icon;
  CustomBtn({Key? key,
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
          width!,
          height!),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),

      )

    );
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
            onPressed: (){},
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


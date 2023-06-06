import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  BigText bigText;
  AppIcon appIcon;
   AccountWidget({Key? key,
     required this.appIcon,
     required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0, 2),
            blurRadius: 1,

          )
        ]
      ),
      padding: EdgeInsets.only(
          left: 20.w,
          top: 10.h,
          bottom: 10.h),
      child: Row(
        children: [
         appIcon,
          SizedBox(width: 10.w,),
          bigText
        ],
      ),
    );
  }
}

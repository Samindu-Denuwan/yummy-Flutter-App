import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class CustomSignIn extends StatelessWidget {
  const CustomSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        height: MediaQuery.of(context).size.height/1.5,
        width: double.maxFinite,
        child: Column(
          children: [
            Lottie.asset(Assets.animationSignIn, fit: BoxFit.cover),
            SizedBox(height: 10.h,),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignIn());

              },
              child: Center(
                child: Container(
                  width: 150.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.w),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                      child: BigText(
                        text: "Sign In", color: Colors.white,)),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}

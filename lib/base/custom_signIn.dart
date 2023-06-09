import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
        height: MediaQuery.of(context).size.height/2,
        width: double.maxFinite,
        child: Column(
          children: [
            Lottie.network("https://assets8.lottiefiles.com/packages/lf20_q5evpnci.json",
              fit: BoxFit.cover,
            ),
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_text_field.dart';
import 'package:yummy/widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            Container(
              height: 200.h,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80.w,
                  backgroundImage: const AssetImage(Assets.SplashScreen_image_1),
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                      text: "Hello", size: 70, fontWeight: FontWeight.w600,),
                  BigText(
                      text: "Sign In to your account", color: Colors.black38,),
                  SizedBox(height: 20.h,),
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            AppTextField(
                textController: emailController,
                hintText: "Email",
                inputType: TextInputType.emailAddress,
                icon: Icons.email),
            SizedBox(height: 20.h,),
            AppTextField(
                textController: passwordController,
                hintText: "Password",
                isPassword: true,
                inputType: TextInputType.visiblePassword,
                icon: Icons.lock),
            SizedBox(height: 30.h,),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:  EdgeInsets.only(right: 20.w),
                child: RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.snackbar("Oh no", "Forgot Password ?"),
                    text: "Forgot Password ?",
                    style: TextStyle(
                      fontFamily: "poppins",
                      fontSize: 15.sp,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            GestureDetector(
              onTap: (){
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
            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontFamily: "poppins",
                        fontSize: 15.sp,
                        color: Colors.black45,
                      ),
                    ),
                ),
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.snackbar("Sign Up", "Don't have an account?"),
                    text: " Create New",
                    style: TextStyle(
                      fontFamily: "poppins",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),


          ],
        ),
      ),
    );
  }
}

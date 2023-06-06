import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_text_field.dart';
import 'package:yummy/widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 15.h),
        child: Column(
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
            SizedBox(height: 20.h,),
            AppTextField(
                textController: nameController,
                hintText: "Name",
                inputType: TextInputType.name,
                icon: Icons.person),
            SizedBox(height: 20.h,),
            AppTextField(
                textController: phoneController,
                hintText: "Phone Number",
                inputType: TextInputType.phone,
                icon: Icons.phone),
            SizedBox(height: 20.h,),
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
            GestureDetector(
              onTap: (){

              },
              child: Container(
                  width: 150.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: AppColors.mainColor
                ),
                child: Center(
                    child: BigText(
                      text: "Sign up", color: Colors.white,)),
              ),
            ),
            SizedBox(height: 20.h,),
            RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.snackbar("Sign In", "Already have an account?"),
                  text: "Already have an account?",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 15.sp,
                    color: Colors.black87,
                  ),
                )),
              SizedBox(height: 20.h,),
              BigText(
            text: "Sign up using  one of the following methods",
            color: Colors.black45, fontWeight: FontWeight.w200,
            size: 13,),
            SizedBox(height: 20.h,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.imageG),
                backgroundColor: Colors.white,
                  radius: 22.w,
                ),
                SizedBox(width: 40.h,),
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.imageT),
                  backgroundColor: Colors.white,
                  radius: 22.w,
                ),
                SizedBox(width: 40.h,),
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.imageF),
                  backgroundColor: Colors.white,
                  radius: 22.w,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

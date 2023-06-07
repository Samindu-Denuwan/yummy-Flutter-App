import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/base/show_custom_snackbar.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/models/sigup_body_model.dart';
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

    void _registration() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Empty Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Empty Phone Number");
      } else if (phone.length!=10) {
        showCustomSnackBar("Type in a valid phone number", title: "Invalid Phone Number");
      }
      else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address", title: "Empty Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address", title: "Invalid Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Empty Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than six characters", title: "Password Error");
      } else {
        showCustomSnackBar("Sign up Successful", title: "Success", icon: Icons.check_circle);
       SignUpBody signUpBody = SignUpBody(
           name:  name,
           phone: phone,
           email: email,
           password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success Register");
          }else{
            showCustomSnackBar(status.message);
          }
        });


      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 15.h),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 200.h,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80.w,
                  backgroundImage:
                      const AssetImage(Assets.SplashScreen_image_1),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                textController: nameController,
                hintText: "Name",
                inputType: TextInputType.name,
                icon: Icons.person),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                textController: phoneController,
                hintText: "Phone Number",
                inputType: TextInputType.phone,
                icon: Icons.phone),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                textController: emailController,
                hintText: "Email",
                inputType: TextInputType.emailAddress,
                icon: Icons.email),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                textController: passwordController,
                hintText: "Password",
                isPassword: true,
                inputType: TextInputType.visiblePassword,
                icon: Icons.lock),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {
                _registration();
              },
              child: Container(
                width: 150.w,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.w),
                    color: AppColors.mainColor),
                child: Center(
                    child: BigText(
                  text: "Sign up",
                  color: Colors.white,
                )),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            RichText(
                text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
              text: "Already have an account?",
              style: TextStyle(
                fontFamily: "poppins",
                fontSize: 15.sp,
                color: Colors.black87,
              ),
            )),
            SizedBox(
              height: 20.h,
            ),
            BigText(
              text: "Sign up using  one of the following methods",
              color: Colors.black45,
              fontWeight: FontWeight.w200,
              size: 13,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.imageG),
                  backgroundColor: Colors.white,
                  radius: 22.w,
                ),
                SizedBox(
                  width: 40.h,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.imageT),
                  backgroundColor: Colors.white,
                  radius: 22.w,
                ),
                SizedBox(
                  width: 40.h,
                ),
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

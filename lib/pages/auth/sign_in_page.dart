import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/base/circular_loader.dart';
import 'package:yummy/base/show_custom_snackbar.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/pages/pages.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_text_field.dart';
import 'package:yummy/widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);
  static final phoneController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();


   if(phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Empty Phone Number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Empty Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than six characters", title: "Password Error");
        passwordController.clear();
      } else {
        authController.login( phone,password).then((status){
          if(status.isSuccess){
            print("Success Login");
            showCustomSnackBar("Login is Successful", title: "Success", icon: Icons.check_circle, color: Colors.green);
            phoneController.clear();
            passwordController.clear();
            Get.offAndToNamed(RouteHelper.getInitial());

          }else{
            showCustomSnackBar(status.message);
          }
        });


      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading? GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      backgroundImage: const AssetImage(Assets.imageLogo1),
                    ),
                  ),
                ),

                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Hello", size: 70, fontWeight: FontWeight.w600,),
                      BigText(
                        text: "Sign In to your account", color: Colors.black38,
                        fontWeight: FontWeight.w300,),
                      SizedBox(height: 20.h,),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),

                AppTextField(
                    textController: phoneController,
                    hintText: "Phone Number",
                    inputType: TextInputType.number,
                    icon: Icons.phone),
                SizedBox(
                  height: 20.h,
                ),
                AppTextField(
                    textController: passwordController,
                    hintText: "Password",
                    isPassword: true,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    icon: Icons.lock),
                SizedBox(
                  height: 30.h,
                ),
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
                    _login(authController);
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
                RichText(
                  text: TextSpan(
                      text: "Don't have an account ? ",
                      style: TextStyle(
                        fontFamily: "poppins",
                        fontSize: 15.sp,
                        color: Colors.black45,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.rightToLeftWithFade),
                          text: " Create New",
                          style: TextStyle(
                            fontFamily: "poppins",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20.h,),

              ],
            ),
          ),
        )
            : CircularLoader();
      },)
    );
  }
}

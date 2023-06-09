import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/base/show_custom_snackbar.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/account_widget.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: "Profile",
            size: 24, color: Colors.white,),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            //profile Icon
            AppIcon(icon: Icons.person,
              backgroundColor: AppColors.mainColor,
            iconColor: Colors.white, size: 150,iconSize: 75,),
            SizedBox(height: 30.h,),
            // Menu list
            Expanded(

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    AccountWidget(appIcon: AppIcon(
                      icon: Icons.person,
                      iconSize: 25,
                      size: 45,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,),
                        bigText: BigText(text: "Samindu")),
                    SizedBox(height: 10.h,),
                    //phone
                    AccountWidget(appIcon: AppIcon(
                      icon: Icons.phone,
                      iconSize: 25,
                      size: 45,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.yellowColor,),
                        bigText: BigText(text: "Samindu",fontWeight: FontWeight.w200,)),
                    SizedBox(height: 10.h,),
                    //email
                    AccountWidget(appIcon: AppIcon(
                      icon: Icons.email,
                      iconSize: 25,
                      size: 45,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.yellowColor,),
                        bigText: BigText(text: "Samindu",fontWeight: FontWeight.w200,)),
                    SizedBox(height: 10.h,),
                    //address
                    AccountWidget(appIcon: AppIcon(
                      icon: Icons.location_on,
                      iconSize: 25,
                      size: 45,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.yellowColor,),
                        bigText: BigText(text: "Samindu",fontWeight: FontWeight.w200,)),
                    SizedBox(height: 10.h,),
                    //message
                    AccountWidget(appIcon: AppIcon(
                      icon: Icons.message,
                      iconSize: 25,
                      size: 45,
                      iconColor: Colors.white,
                      backgroundColor: Colors.blue,),
                        bigText: BigText(text: "Samindu",fontWeight: FontWeight.w200,)),
                    SizedBox(height: 10.h,),
                    //logout
                    GestureDetector(
                      onTap: (){
                        if(Get.find<AuthController>().userLoggedIn()){
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          print("Logout");
                          Get.offNamed(RouteHelper.getSignIn());
                        }else{
                          showCustomSnackBar("You already logged out", title: "Logging Out");
                        }
                        
                      },
                      child: AccountWidget(appIcon: AppIcon(
                        icon: Icons.logout,
                        iconSize: 25,
                        size: 45,
                        iconColor: Colors.white,
                        backgroundColor: Colors.red,),
                          bigText: BigText(text: "Logout", fontWeight: FontWeight.w200,)),
                    ),
                    SizedBox(height: 20.h,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

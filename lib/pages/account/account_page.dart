import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/base/circular_loader.dart';
import 'package:yummy/base/custom_signIn.dart';
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
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
      print("user loggin in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: "My Profile",
            size: 19, color: Colors.white,),
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
        return _userLoggedIn?(!userController.isLoading?Container(
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
                          bigText: BigText(text: userController.userModel!= null? userController.userModel!.name: "Your Name")),
                      SizedBox(height: 10.h,),
                      //phone
                      AccountWidget(appIcon: AppIcon(
                        icon: Icons.phone,
                        iconSize: 25,
                        size: 45,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.yellowColor,),
                          bigText: BigText(
                            text: userController.userModel!= null?  userController.userModel!.phone: "Your Phone Number",
                            fontWeight: FontWeight.w100,
                            size: 16,)),
                      SizedBox(height: 10.h,),
                      //email
                      AccountWidget(appIcon: AppIcon(
                        icon: Icons.email,
                        iconSize: 25,
                        size: 45,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.yellowColor,),
                          bigText: BigText(
                            text:userController.userModel!= null?  userController.userModel!.email: "Your Email",
                            fontWeight: FontWeight.w100,
                          size: 16,)),

                      SizedBox(height: 10.h,),
                      //address
                      GetBuilder<LocationController>(
                        builder: (locationController) {
                        if(_userLoggedIn&& locationController.addressList.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getAddressPage());

                            },
                            child: AccountWidget(appIcon: AppIcon(
                              icon: Icons.location_on,
                              iconSize: 25,
                              size: 45,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.yellowColor,),
                                bigText: BigText(text: "Fill in your Address",
                                  fontWeight: FontWeight.w100,
                                  size: 16,)),
                          );
                        }else{
                        return  GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getAddressPage());

                            },
                            child: AccountWidget(appIcon: AppIcon(
                              icon: Icons.location_on,
                              iconSize: 25,
                              size: 45,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.yellowColor,),
                                bigText: BigText(text:  locationController.addressList[0].address,
                                  fontWeight: FontWeight.w100,
                                  size: 16,)),
                          );
                        }
                      },),
                      SizedBox(height: 10.h,),
                      //message
                      GestureDetector(
                        onTap: (){
                          print("localStorage address:.........."+ Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last).toString());
                        },
                        child: AccountWidget(appIcon: AppIcon(
                          icon: Icons.message,
                          iconSize: 25,
                          size: 45,
                          iconColor: Colors.white,
                          backgroundColor: Colors.blue,),
                            bigText: BigText(text: "Messages",
                              fontWeight: FontWeight.w100,
                              size: 16,)),
                      ),
                      SizedBox(height: 10.h,),
                      //logout
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            print("Logout");
                            Get.offAndToNamed(RouteHelper.getSignIn());
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
                            bigText: BigText(text: "Logout",
                              fontWeight: FontWeight.w200,
                              size: 16,)),
                      ),
                      SizedBox(height: 20.h,),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
            :const CircularLoader())
            : CustomSignIn();
      },),
    );
  }
}

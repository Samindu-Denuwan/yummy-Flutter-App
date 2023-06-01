import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/small_text.dart';

import '../home/main_food_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios_new,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>const MainFoodPage());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: 22,
                    ),
                  ),
                  AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor),
                ],
              )),
          Positioned(
              top: 100.h,
              left: 20.w,
              right: 20.w,
              bottom: 0,
              child: Container(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartController) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartController.getItems.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: 100.h,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 90.h,
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.w),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!),
                                      ),
                                )
                                ),
                                SizedBox(width: 10.w,),
                                Expanded(
                                  child: Container(
                                    height: 90.h,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "LKR ${cartController.getItems[index].price}", color: Colors.red,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20.w),
                                                      color: Colors.white),
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){},
                                                        child: const Icon(
                                                          Icons.remove,
                                                          color: AppColors.signColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      BigText(
                                                        text: "0",
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){

                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: AppColors.signColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                  },),
                ),
              )),
        ],
      ),
    );
  }
}

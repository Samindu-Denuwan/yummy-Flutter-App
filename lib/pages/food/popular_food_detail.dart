import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_column.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarColor: AppColors.buttonBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: AssetImage("assets/image/food0.png"))
                  ),
                ),
            ),
            Positioned(
              top: 45.h,
              left: 20.w,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(icon: Icons.arrow_back_ios_new, backgroundColor: Colors.white30),
                    AppIcon(icon: Icons.shopping_cart_outlined, backgroundColor: Colors.white30),
                  ],
                ),),
            Positioned(
              left: 0,
                right: 0,
                top: 350.h-30.h,
                bottom: 0,
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight:Radius.circular(20.w)),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: "Chinese Side", size: 24,),
                    SizedBox(height: 20.h,),
                    BigText(text: "Introduce", size: 16,
                      color: AppColors.mainBlackColor.withOpacity(0.6),),
                    SizedBox(height: 20.h,),
                  ],
                ),
                )
            ),

          ],
        ),
      bottomNavigationBar: Container(
        height: 120.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.w), topRight: Radius.circular(50.w)),
          color: AppColors.buttonBackgroundColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor,),
                  SizedBox(width: 8.w,),
                  BigText(text: "0", ),
                  SizedBox(width: 8.w,),
                  Icon(Icons.add ,color: AppColors.signColor,),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: AppColors.mainColor
              ),
              child: Row(
                children: [
                  BigText(text: "LKR 1500 |" , color: Colors.white, ),
                  SizedBox(width: 5.w,),
                  Icon(Icons.add_shopping_cart ,color: Colors.white),
                  //BigText(text: "| Add to cart", size: 16, color: Colors.white, ),



                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}

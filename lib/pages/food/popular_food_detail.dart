import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/controllers/popular_product_controller.dart';
import 'package:yummy/pages/cart/cart_page.dart';
import 'package:yummy/pages/home/main_food_page.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_column.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/expandable_text.dart';
import 'package:yummy/widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail( {Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().
    popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350.h,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!)
                  )
              ),
            ),
          ),
          //icon widget
          Positioned(
            top: 45.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                      Get.to(()=>const MainFoodPage());
                  },
                  child: AppIcon(
                      icon: Icons.arrow_back_ios_new,
                      ),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: GestureDetector(
                          onTap:(){
                            Get.to(()=> CartPage());
                          },
                          child: AppIcon(
                            icon: Icons.shopping_cart_outlined,
                          ),
                        ),
                      ),
                      Get.find<PopularProductController>().totalItems>= 1?
                      Positioned(
                        right:0,
                        top:0,
                        child: AppIcon(
                          icon: Icons.circle, size: 20, iconColor: Colors.transparent,
                          backgroundColor: AppColors.mainColor,
                        ),
                      ):
                      Container(),
                      Get.find<PopularProductController>().totalItems>= 1?
                      Positioned(
                        right:5.w,
                        top:2.h,
                        child: BigText(text:"${controller.totalItems}",
                          color: Colors.white,
                        size: 12,),
                      ):
                      Container()
                    ],
                  );
                },)   ],
            ),
          ),
          //food details
          Positioned(
              left: 0,
              right: 0,
              top: 350.h - 30.h,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        topRight: Radius.circular(20.w)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name!,
                      size: 24,
                      stars: product.stars!,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BigText(
                      text: "Introduce",
                      size: 16,
                      color: AppColors.mainBlackColor.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Expanded(

                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(bottom: 130.h),
                        child:  ExpandableTextWidget(
                            text:product.description!
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          // Expandable text
        ],
      ),
      bottomNavigationBar:GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
              height: 120.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.w),
                      topRight: Radius.circular(50.w)),
                  color: AppColors.buttonBackgroundColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w),
                        color: Colors.white),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){popularProduct.setQuantity(false);},
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        BigText(
                          text: "${popularProduct.inCartItems}",
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(true);
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      popularProduct.addItems(product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: AppColors.mainColor),
                      child: Row(
                        children: [
                          BigText(
                            text: "LKR ${product.price} |",
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const Icon(Icons.add_shopping_cart, color: Colors.white),
                          //BigText(text: "| Add to cart", size: 16, color: Colors.white, ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },)
    );
  }
}

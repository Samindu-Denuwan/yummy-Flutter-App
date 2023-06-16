import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/controllers/popular_product_controller.dart';
import 'package:yummy/controllers/recommended_product_controller.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().
    recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               GestureDetector(
                 onTap: (){
                   if(page =="cartPage"){
                     Get.toNamed(RouteHelper.getCartPage());
                   }else{
                     Get.toNamed(RouteHelper.getInitial());
                   }
                 },
                   child: AppIcon(icon: Icons.close)),
               GetBuilder<PopularProductController>(builder: (controller) {
                 return GestureDetector(
                   onTap:(){
                     Get.toNamed(RouteHelper.getCartPage());
                   },
                   child: Stack(
                     children: [
                       AppIcon(
                         icon: Icons.shopping_cart_outlined,
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
                   ),
                 );
               },)
             ],
            ),
            toolbarHeight: 70.h,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20.h),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.h),
                    topRight: Radius.circular(20.h),
                    ),
                    color: Colors.white,

                  ),
                  child: Center(
                      child:
                      BigText(
                        text: product.name!, size: 22,)),
                )),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300.h,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(imageUrl: AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                placeholder:(context, url) => Lottie.asset(Assets.animationPlaceholder,
                    fit: BoxFit.cover),
                width: double.maxFinite,
                fit: BoxFit.cover,),
            ),
          ),
           SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical:10.h,horizontal: 20.w),
                    child:  ExpandableTextWidget(
                        text:product.description! ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          controller.setQuantity(false);
                        },
                        child: AppIcon(icon: Icons.remove,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: 24,
                        ),
                      ),
                      BigText(text: "LKR ${product.price!}  X  ${controller.inCartItems}"),
                      GestureDetector(
                        onTap: (){
                            controller.setQuantity(true);
                        },
                        child: AppIcon(icon: Icons.add,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: AppColors.mainColor,

                            ),

                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          controller.addItems(product);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.w),
                              color: AppColors.mainColor),
                          child: Row(
                            children: [
                              BigText(
                                text: "LKR ${product.price!} |",
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
                ),

              ],
            );
          },),
    );
  }
}

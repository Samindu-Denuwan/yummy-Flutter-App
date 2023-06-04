import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/controllers/popular_product_controller.dart';
import 'package:yummy/controllers/recommended_product_controller.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/small_text.dart';
import 'package:lottie/lottie.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark
          ),

        ),
      body: Stack(
        children: [
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){},
                    child: AppIcon(
                      icon: Icons.arrow_back_ios_new,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
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
         GetBuilder<CartController>(builder: (cartController) {
           return cartController.getItems.isNotEmpty? Positioned(
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
                       var _cartList = cartController.getItems;
                       return ListView.builder(
                         shrinkWrap: true,
                         itemCount: _cartList.length,
                         itemBuilder: (_, index) {
                           return Container(
                             height: 100.h,
                             width: double.maxFinite,
                             child: Row(
                               children: [
                                 GestureDetector(
                                   onTap: (){
                                     var popularIndex = Get.find<PopularProductController>()
                                         .popularProductList
                                         .indexOf(_cartList[index].product!);

                                     if(popularIndex>=0){
                                       Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartPage"));
                                     }else{
                                       var recommendedIndex = Get.find<RecommendedProductController>()
                                           .recommendedProductList
                                           .indexOf(_cartList[index].product!);
                                       if(recommendedIndex<0){
                                         Get.snackbar("History Product", "Product review is not available for history products.",
                                             icon: Icon(Icons.error, size: 30.sp, color: Colors.white30,),
                                             backgroundColor: Colors.red,
                                             colorText: Colors.white,
                                             margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w));
                                       }else{
                                         Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartPage"));
                                       }
                                     }
                                   },
                                   child: Container(
                                       width: 90.w,
                                       height: 90.h,
                                       margin: EdgeInsets.only(bottom: 10.h),
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20.w),
                                         image: DecorationImage(
                                           fit: BoxFit.cover,
                                           image: NetworkImage(
                                               AppConstants.BASE_URL+AppConstants.UPLOAD_URL+_cartList[index].img!),
                                         ),
                                       )
                                   ),
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
                                         BigText(text: _cartList[index].name!, color: Colors.black54,),
                                         SmallText(text: "Spicy"),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             BigText(text: "LKR ${_cartList[index].price}", color: Colors.red,),
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
                                                         onTap: (){
                                                           cartController.addItem(_cartList[index].product!, -1, false);
                                                         },
                                                         child: const Icon(
                                                           Icons.remove,
                                                           color: AppColors.signColor,
                                                         ),
                                                       ),
                                                       SizedBox(
                                                         width: 8.w,
                                                       ),
                                                       BigText(
                                                         text: '${_cartList[index].quantity}',
                                                       ),
                                                       SizedBox(
                                                         width: 8.w,
                                                       ),
                                                       GestureDetector(
                                                         onTap: (){
                                                           cartController.addItem(_cartList[index].product!, 1, false);
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
                           ) ;
                         },
                       );
                     },),
                 ),
               )):  Column(
             mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Center(
             child: Container(
                   width: double.infinity,
                   child: Column(
                     children: [
                       Lottie.network(AppConstants.EMPTY_CART),
                       SizedBox(height: 30.h,),
                       Center(child: BigText(text: "No Food Items yet?", color: Colors.black26,)),
                       Center(child: BigText(text: "Explore more", color: Colors.black26,)),

                     ],
                   ),
             ),
           ),
                 ],
               );

         },)
        ],

      ),
        bottomNavigationBar:GetBuilder<CartController>(
          builder: (cartController) {
            var _cartList = cartController.getItems;
            return  _cartList.isNotEmpty?
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
                    child: BigText(text: "LKR ${cartController.totalAmount}"),
                  ),
                  GestureDetector(
                    onTap: (){
                        cartController.addToHistory();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: AppColors.mainColor),
                      child: BigText(
                        text: "Checkout",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ) : Container(
              height: 0.h,
            );
          },)
    );

  }
}

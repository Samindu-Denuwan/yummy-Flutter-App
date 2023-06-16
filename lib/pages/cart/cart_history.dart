import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/base/no_data_page.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/small_text.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for(int i =0; i<getCartHistoryList.length; i++){
      if( cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value)=> ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, ()=> 1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

   Widget timeWidget(int index){
     var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse("$parseDate");
        var outputFormat =  DateFormat("MM-dd-yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(color: Colors.black54, text: outputDate, size: 14,);
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.mainColor,
          statusBarBrightness: Brightness.light
        ),

      ),

      body: Column(
        children: [
              Container(
                height: 65.h,
                color: AppColors.mainColor,
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigText(text: "Cart History", color: Colors.white, size: 19,),
                    AppIcon(icon: Icons.shopping_cart_outlined,),
                  ],
                ),
              ),
          GetBuilder<CartController>(builder: (cartController) {
          return  cartController.getCartHistoryList().isNotEmpty?
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, ),
                child: MediaQuery.removePadding(
                    context: context, child: ListView(
                  children: [
                    for(int i= 0; i<itemsPerOrder.length; i++)
                      Container(
                        height: 120.h,
                        margin: EdgeInsets.only(bottom: 15.h),
                        child: Column(
                          crossAxisAlignment:  CrossAxisAlignment.start,
                          children: [
                            timeWidget(listCounter),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if(listCounter< getCartHistoryList.length){
                                      listCounter++;
                                    }
                                    return index<=2? Container(
                                      height: 70.w,
                                      width: 70.w,
                                      margin: EdgeInsets.only(right: 5.w),
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(8.w),
                                      //     image: DecorationImage(
                                      //         fit: BoxFit.cover,
                                      //         image: CachedNetworkImageProvider(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!),
                                      //     )
                                      // ),
                                      child: CachedNetworkImage(imageUrl: AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!,
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: 70.w,
                                          width: 70.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.w),
                                            image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) =>  Lottie.asset(Assets.animationImageLoading,
                                            fit: BoxFit.cover)  ,
                                        errorWidget: (context, url, error) =>
                                        const Image(image: AssetImage(Assets.imageLoadImage), fit: BoxFit.cover,)  ,
                                      ),

                                    ): Container();
                                  }),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text: "Total"),
                                      SizedBox(height: 5.h,),
                                      BigText(text: "${itemsPerOrder[i]} Items", color: AppColors.titleColor,),
                                      SizedBox(height: 5.h,),
                                      GestureDetector(
                                        onTap: (){
                                          var orderTime = cartOrderTimeToList();
                                          Map<int, CartModel> moreOrder = {};
                                          for(int j=0; j<getCartHistoryList.length; j++){
                                            if(getCartHistoryList[j].time == orderTime[i]){
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                  CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                              );
                                            }
                                          }
                                          Get.find<CartController>().setItems = moreOrder;
                                          Get.find<CartController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.w),
                                              border: Border.all(
                                                width: 1.w,
                                                color: AppColors.mainColor,
                                              )
                                          ),
                                          child: SmallText(text: "One more", color: AppColors.mainColor, size: 8,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),


                  ],
                )),
              ),
            ):
          Center(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 30.h,),
                  Lottie.asset(Assets.animationEmpty, fit: BoxFit.cover),
                  SizedBox(height: 30.h,),
                  Center(child: BigText(text: "You didn't buy anything so far !", color: Colors.black26,)),
                  Center(child: BigText(text: "Explore more", color: Colors.black26,)),
                ],
              ),
            ),
          );

          },)
        ],
      ),
    );
  }
}

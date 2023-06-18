import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/base/circular_loader.dart';
import 'package:yummy/controllers/order_controller.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/models/order_model.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/small_text.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (
          orderController) {
        if(orderController.isLoading==false){
          late List<OrderModel> orderList;
          if(orderController.runningOrderList.isNotEmpty){
            orderList =isCurrent? orderController.runningOrderList.reversed.toList()
                :orderController.historyOrderList.reversed.toList();
          }else{
            orderList = [];
            return Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                    child: Lottie.asset(Assets.animationLoadingPage, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 50.h,
                    left: 0,
                    right: 0,
                    child: Lottie.asset(Assets.animationMyOrdes,
                       fit: BoxFit.cover)
                ),
                Positioned(
                    bottom: 30.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          BigText(
                            text: "No Food Items yet?",
                            color: Colors.black26,
                          ),
                          BigText(
                            text: "Explore more",
                            color: AppColors.mainColor,
                          )
                        ],
                      ),
                    )
                )
              ],
            );
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: AppColors.mainColor.withOpacity(0.2),
                    onTap: (){
                       // showModalBottomSheet(
                       //  backgroundColor: Colors.transparent,
                       //    context: context, builder: (_) {
                       //    return Container(
                       //      width: MediaQuery.of(context)
                       //          .size
                       //          .width,
                       //      decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.only(
                       //            topLeft:
                       //            Radius.circular(50.w),
                       //            topRight:
                       //            Radius.circular(50.w),
                       //          ),
                       //          color: Colors.white),
                       //           child: Padding(
                       //        padding:
                       //        EdgeInsets.only(top: 20.h),
                       //        child: Column(
                       //          children: [
                       //            Expanded(
                       //              child:
                       //              SingleChildScrollView(
                       //                child: Column(
                       //                  children: [
                       //                    Container(
                       //                      decoration: BoxDecoration(
                       //                          borderRadius:
                       //                          BorderRadius
                       //                              .circular(10
                       //                              .w),
                       //                          color: Colors
                       //                              .grey
                       //                              .shade400),
                       //                      width: 50.w,
                       //                      height: 5.h,
                       //                    ),
                       //                    SizedBox(
                       //                      height: 8.h,
                       //                    ),
                       //                    Container(
                       //                      padding: EdgeInsets
                       //                          .only(
                       //                          left:
                       //                          20.w,
                       //                          right:
                       //                          20.w),
                       //                      //height: 540.h,
                       //                      child: Column(
                       //                        crossAxisAlignment: CrossAxisAlignment.start,
                       //                        children: [
                       //                          Row(
                       //                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       //                            children: [
                       //                              BigText(text: "Total :"),
                       //                              BigText(text: "\$ ${orderList[index].orderAmount}"),
                       //                            ],
                       //                          ),
                       //                        ],
                       //                      ),
                       //                    ),
                       //                  ],
                       //                ),
                       //              ),
                       //            ),
                       //
                       //          ],
                       //        ),
                       //      ),
                       //    );
                       //    },);
                    },
                      child: Container(
                        padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SmallText(text: 'ORDER ID : ', color: Colors.black54,
                                  size: 14,),
                                SmallText(text: ' #${orderList[index].id}', color: Colors.black,
                                  size: 14, fontWeight: FontWeight.w500,)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: '${orderList[index].orderStatus}'== 'success' ?Colors.green:
                                    '${orderList[index].orderStatus}'== 'canceled' ?Colors.red:
                                    '${orderList[index].orderStatus}'== 'confirmed' ?Colors.blue:
                                    '${orderList[index].orderStatus}'== 'failed' ?Colors.red:
                                    '${orderList[index].orderStatus}'== 'pending' ?Colors.deepOrangeAccent:
                                        AppColors.mainColor
                                  ),
                                  child: SmallText(text: '${orderList[index].orderStatus}',
                                  color: Colors.white,
                                  size: 10,),
                                ),
                                SizedBox(height:10.h ,),
                                InkWell(
                                  onTap: (){
                                    print("Track");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.w),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1
                                      )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.track_changes, color: AppColors.mainColor, size: 18.sp,),
                                        SizedBox(width: 5.w,),
                                        SmallText(text: 'Track Order', color: AppColors.mainColor,
                                        size: 10,),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.h),
                                  width: MediaQuery.of(context).size.width/2,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1, color: Colors.grey.shade300
                                      )
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  );
                },),
          );
        }else{
          return Center(
            child: Container(
              width: double.infinity,
              child: Lottie.asset(Assets.animationLoadingPage, fit: BoxFit.cover),
            ),
          );
        }

      },),
    );
  }
}

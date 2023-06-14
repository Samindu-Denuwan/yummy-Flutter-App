import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/base/circular_loader.dart';
import 'package:yummy/controllers/order_controller.dart';
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
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: AppColors.mainColor.withOpacity(0.2),
                    onTap: (){
                      print("order");
                    },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 15.h, left: 20.w, right: 20.w, top: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(text: 'ORDER ID:  #${orderList[index].id}', color: Colors.black,
                            size: 12,),
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
                              ],
                            ),
                          ],
                        ),
                      ),
                  );
                },),
          );
        }else{
          return CircularLoader();
        }

      },),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class PaymentOptionBtn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;
  const PaymentOptionBtn({Key? key, required this.icon, required this.title, required this.subTitle, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
     bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          margin: EdgeInsets.symmetric( vertical: 8.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                _selected?
                const BoxShadow(
                  color: AppColors.mainColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                ) :BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 5,
                  spreadRadius: 1,


                )
              ]

          ),
          child: ListTile(
            leading: Icon(icon, size: 40.sp,
              color:_selected? AppColors.mainColor: Colors.grey,),
            title: BigText(text: title, color: Colors.black87, fontWeight: FontWeight.w500,
              size: 16,),
            subtitle: BigText(text: subTitle, color: Colors.black45, fontWeight: FontWeight.w400,
              size: 10, ),
            trailing:_selected? Icon(Icons.check_circle, size: 25.sp,
                color:AppColors.mainColor): null,
          ),
        ),
      );
    },);

  }
}

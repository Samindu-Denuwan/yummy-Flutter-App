import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class DeliveryOption extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOption({Key? key, required this.value, required this.title, required this.amount, required this.isFree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(

            activeColor: AppColors.mainColor,
            value: value,
            groupValue: orderController.deliveryType,
            onChanged: (String? value)=>orderController.setDeliveryType(value!),
          ),
          BigText(text: title, size: 16, color: Colors.black87,fontWeight: FontWeight.w400,),
          SizedBox(width: 5.w,),
          BigText(text: "(${(value=='take away' || isFree)?'Free':'\$ ${amount/10} '})",size: 16,),

        ],
      );
    },);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yummy/controllers/order_controller.dart';
import 'package:yummy/utils/colors.dart';

class AdditionalNotesTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final TextInputAction inputAction;
  final TextInputType inputType;
  bool isPassword;
  AdditionalNotesTextField({Key? key,
    this.isPassword = false,
    this.inputAction = TextInputAction.next,
    required this.textController,
    required this.hintText,
    required this.icon,
    required this.inputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool _isToogle = orderController.isToggled;
      return Column(
        children: [
          _isToogle?
          Container(
            height: 90.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2)
                  )
                ]
            ),
            child: TextField(
              keyboardType: inputType,
              maxLines: 3,
              textInputAction: inputAction,
              obscureText: isPassword,
              style:  TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300
              ),
              controller: textController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w200,
                  fontSize: 13.sp,
                ),
                prefixIcon:  Icon(icon, color: AppColors.mainColor,),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.w),
                  borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.white
                  ),
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.w),
                  borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.white
                  ),
                ),
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.w),

                ),
              ),

            ),
          ):Container(),
          _isToogle?
          SizedBox(
            height: 25.h,
          ):SizedBox()
        ],
      );

    },);
  }
}

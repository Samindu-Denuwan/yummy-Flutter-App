import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/utils/colors.dart';

class CustomToggle extends StatelessWidget {
  const CustomToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Switch(
          activeColor: Colors.white,
          activeTrackColor: AppColors.mainColor,
          inactiveTrackColor: Colors.white,
          inactiveThumbColor: Colors.grey,
          value: orderController.isToggled,
          onChanged: (toggle) => orderController.setToggled(toggle));
    });
  }
}

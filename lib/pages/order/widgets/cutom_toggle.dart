import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy/controllers/controllers.dart';

class CustomToggle extends StatelessWidget {
  final bool value;
  const CustomToggle({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool _selected = orderController.isToggled == value;
      return Switch(
          value: value,
          onChanged: (toggle)=>orderController.setToggled(toggle));

    });

    }
}

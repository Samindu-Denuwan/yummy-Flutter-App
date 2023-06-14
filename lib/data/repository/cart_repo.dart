import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yummy/utils/colors.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){
     // sharedPreferences.remove(AppConstants.CART_LIST);
     // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);

    var time = DateTime.now().toString();
    cart =[];
    //convert objects to string
    cartList.forEach((element){
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList
      (AppConstants.CART_LIST, cart);
    //getCartList();
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartList(){
    List<String> carts = [];
if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
 carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
 print("inside Cart List ${carts}");
}
    List<CartModel> cartList = [];

    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      //cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) => cartListHistory.add(
        CartModel.fromJson(
            jsonDecode(
                element))));
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i = 0; i<cart.length; i++){
      cartHistory.add(cart[i]);
    }
    cart=[];
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    Get.snackbar("Checkout", "Checkout Complete!.",
        icon: Icon(Icons.check_circle, size: 30.sp, color: Colors.white,),
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w));
  }

  void removeCart() {
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory =[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);

  }

  void removeCartSharedPreference() {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }


}

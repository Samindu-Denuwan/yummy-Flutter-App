import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList){
    cart =[];
    //convert objects to string
    cartList.forEach((element) => cart.add(jsonEncode(element)));

    sharedPreferences.setStringList
      (AppConstants.CART_LIST, cart);
    getCartList();
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

}

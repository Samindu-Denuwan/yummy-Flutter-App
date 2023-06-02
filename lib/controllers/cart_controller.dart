import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/data/repository/cart_repo.dart';
import 'package:yummy/models/cart_model.dart';
import 'package:yummy/models/products_model.dart';
import 'package:yummy/utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  //for sharedPreferences
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity, bool pageStatus) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {

        totalQuantity = value.quantity!+quantity;

        if(pageStatus){
          Get.snackbar("Change Item Count", "Successfully change item count in the cart.",
              icon: Icon(Icons.check_circle, size: 30.sp, color: Colors.white,),
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w));
        }

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id!);
      }
    } else {
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
          Get.snackbar("Added to Cart", "Successfully add ${product.name!}to cart.",
              icon: Icon(Icons.check_circle, size: 30.sp, color: Colors.white,),
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w));
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      }else{
        Get.snackbar("Error", "You should add at least an item in the cart.",
            icon: Icon(Icons.error, size: 30.sp, color: Colors.white30,),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w));
      }
    }

    cartRepo.addToCartList(getItems);

    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key== product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity =0;
    _items.forEach((key, value) {
     totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }


  List<CartModel> get getItems{
   return _items.entries.map((e) {
     return  e.value;
    }).toList();
  }

  int get totalAmount{
    var total =0;
    _items.forEach((key, value) {
      total += value.quantity!* value.price!;
    });
    return total;
  }

 List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();

    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    print("Length of cart items:...... ${storageItems.length}");
    for(int i = 0; i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

}

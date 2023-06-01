import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/data/repository/popular_product_repo.dart';
import 'package:yummy/models/products_model.dart';
import 'package:yummy/utils/colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool  get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity=> _quantity;
  int _inCartItems =0;
  int get inCartItems => _inCartItems+_quantity;

  Future<void> getPopularProductList()async{
   Response response = await popularProductRepo.getPopularProductList();
  if(response.statusCode == 200){
    _popularProductList = [];
    _popularProductList.addAll(Product.fromJson(response.body).products);
    _isLoaded = true;
    update();
  }else{

  }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }

  int checkQuantity (int quantity){
    if((_inCartItems+quantity)< 0){
      Get.snackbar("Item Count", "You can't reduce more!",
      backgroundColor: Colors.red,
      margin: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
      colorText: Colors.white,
          icon: Icon(Icons.error, color: Colors.white, size: 30.sp,));
      return 0;
    }else if( (_inCartItems+quantity)>20){
      Get.snackbar("Item Count", "You can't add more!",
          backgroundColor: Colors.red,
          margin: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
          colorText: Colors.white,
          icon: Icon(Icons.error, color: Colors.white, size: 30.sp,));
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart ){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    print("exist or not $exist");
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    print("qty Cart is $_inCartItems");
    // get from storage _inCartItems

  }

  void addItems(ProductModel product){
      _cart.addItem(product, _quantity);

      _quantity=0;
      _inCartItems = _cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print("The id is ${value.id}The qty is ${value.quantity}");
      });



  }


}
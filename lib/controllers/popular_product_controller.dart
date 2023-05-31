import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/data/repository/popular_product_repo.dart';
import 'package:yummy/models/products_model.dart';
import 'package:yummy/utils/colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool  get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity=> _quantity;

  Future<void> getPopularProductList()async{
   Response response = await popularProductRepo.getPopularProductList();
  if(response.statusCode == 200){
    print("Got Products");
    _popularProductList = [];
    _popularProductList.addAll(Product.fromJson(response.body).products);
    //print(_popularProductList);
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
    if(quantity< 0){
      Get.snackbar("Item Count", "You can't reduce more!",
      backgroundColor: AppColors.mainColor,
      margin: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
      colorText: Colors.white,
          icon: Icon(Icons.error, color: Colors.white, size: 30.sp,));
      return 0;
    }else if( quantity>20){
      Get.snackbar("Item Count", "You can't add more!",
          backgroundColor: AppColors.mainColor,
          margin: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
          colorText: Colors.white,
          icon: Icon(Icons.error, color: Colors.white, size: 30.sp,));
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(){
    _quantity = 0;
  }


}
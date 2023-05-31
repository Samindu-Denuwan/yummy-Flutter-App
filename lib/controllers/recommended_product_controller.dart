import 'package:get/get.dart';
import 'package:yummy/models/products_model.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool  get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList()async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      print("Got Recommended Products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else{

    }
  }

}
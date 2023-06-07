import 'package:get/get.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/data/api/api_client.dart';
import 'package:yummy/data/repository/repository.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> init() async {
  final sharedPreferences =await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);

  //api clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  


  //controllers
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));

  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));

  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}

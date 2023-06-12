import 'package:get/get.dart';
import 'package:yummy/routes/route_helper.dart';

import '../../base/show_custom_snackbar.dart';

class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(RouteHelper.getSignIn());
    }else{
      showCustomSnackBar(response.statusText!);
    }
  }
}
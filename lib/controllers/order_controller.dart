import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yummy/data/api/api_checker.dart';
import 'package:yummy/data/repository/order_repo.dart';
import 'package:yummy/models/place_order_model.dart';

class OrderController extends GetxController implements GetxService{
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback)async{
    _isLoading = true;
    Response response =await orderRepo.placeOrder(placeOrder);
    print(response.statusCode.toString());
    if(response.statusCode==200){
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callback(true, message, orderID);
    }else{
      callback(false, response.statusText!, '-1');
    }

  }
}
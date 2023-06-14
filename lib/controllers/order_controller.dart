import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yummy/data/repository/order_repo.dart';
import 'package:yummy/models/order_model.dart';
import 'package:yummy/models/place_order_model.dart';

class OrderController extends GetxController implements GetxService{
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  late List<OrderModel> _runningOrderList;
  late List<OrderModel> _historyOrderList;
  List<OrderModel> get runningOrderList=> _runningOrderList;
 List<OrderModel>get historyOrderList=> _historyOrderList;
  bool get isLoading => _isLoading;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _deliveryType = 'delivery';
  String get deliveryType  => _deliveryType;

  bool _isToggled = false;
  bool get isToggled  => _isToggled;

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

  Future<void> getOrderList()async {
  _isLoading = true;
 Response response = await orderRepo.getOrderList();
 if(response.statusCode ==200){
    _historyOrderList = [];
    _runningOrderList = [];

    response.body.forEach((order){
      OrderModel orderModel = OrderModel.fromJson(order);
      if(orderModel.orderStatus== 'pending'||
          orderModel.orderStatus== 'accepted'||
          orderModel.orderStatus== 'processing'||
          orderModel.orderStatus== 'confirmed'||
          orderModel.orderStatus== 'handover'||
          orderModel.orderStatus== 'picked_up'
      ){
        _runningOrderList.add(orderModel);

      }else{
        _historyOrderList.add(orderModel);
      }
    });
 }else{
  _historyOrderList = [];
  _runningOrderList = [];
 }
 _isLoading = false;
 update();
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type){
    _deliveryType = type;
    update();
  }

  void setToggled(bool value){
    _isToggled = value;
    update();
  }


}
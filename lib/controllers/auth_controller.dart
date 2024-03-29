import 'package:get/get.dart';
import 'package:yummy/data/repository/auth_repo.dart';
import 'package:yummy/models/response_model.dart';
import 'package:yummy/models/sigup_body_model.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
   Response response =await authRepo.registration(signUpBody);
  late ResponseModel responseModel;
   if(response.statusCode ==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      print("Token..............:"+response.body["token"].toString());
   }else{
     responseModel = ResponseModel(false, response.statusText!);
   }
    _isLoading = false;
   update();
   return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response =await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if(response.statusCode ==200){
      print("TOKEN...........:"+response.body["token"].toString());
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn()  {
    return authRepo.userLoggedIn() ;
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}
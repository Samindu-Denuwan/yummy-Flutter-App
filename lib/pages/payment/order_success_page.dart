
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/base/btn_custom.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({Key? key, required this.orderID, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(status ==0){
      Future.delayed(Duration(seconds: 1), (){

      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Lottie.network(status==1? AppConstants.CHECKED_ANIMATION:AppConstants.WARNING_ANIMATION,
                width: 300.w,
                height: 300.h,
                fit: BoxFit.cover),
              ),
              SizedBox(height: 45.h,),
              Text(status==1? 'You placed the order': 'Your order is',
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h,),
              Text( status==1? 'Successfully': 'Failed',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color:status==1? Colors.green: Colors.red
              ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h
                  ),
                child: Center(
                  child: Text( status==1? 'Successful Order': 'Failed Order',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                    //textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              Padding(
                  padding: EdgeInsets.all(20.w),
                child: GestureDetector(
                  onTap: (){
                    Get.find<CartController>().addToHistory();
                    Get.offAllNamed(RouteHelper.getInitial());
                  },
                  child: BtnCustom(
                      color: AppColors.mainColor,
                      width: 200,
                      bigText: BigText(text: "Back to Home",color: Colors.white,),
                      margin: EdgeInsets.symmetric(horizontal: 30.w)),
                ),
              )
              ,

            ],
          ),
        ),
      ),
    );
  }
}

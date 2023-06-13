
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/base/btn_custom.dart';
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
            children: [
              Center(
                child: Lottie.network(status==1? AppConstants.CHECKED_ANIMATION:AppConstants.WARNING_ANIMATION,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover),
              ),
              SizedBox(height: 45.h,),
              Center(
                child: Text( status==1? 'You placed the order successfully': 'Your order failed',
                style: TextStyle(
                  fontSize: 24.sp,
                ),
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h
                  ),
                child: Text( status==1? 'Successful Order': 'Failed Order',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height:30.h,),
              Padding(
                  padding: EdgeInsets.all(20.w),
                child: GestureDetector(
                  onTap: (){
                    Get.offAllNamed(RouteHelper.getInitial());
                  },
                  child: BtnCustom(
                      color: AppColors.mainColor,
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

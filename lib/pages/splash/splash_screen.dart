
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/routes/route_helper.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(
        vsync: this, 
        duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(
        parent: controller, 
        curve: Curves.linear);
    Timer(
        const Duration(seconds: 3),
            () => Get.toNamed(RouteHelper.getInitial()));
  }

 Future<void> _loadResources()  async {
  await Get.find<PopularProductController>().getPopularProductList();
  await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Center(
              child: ScaleTransition(
                  scale: animation,
                  child: Image(
                    image: const AssetImage(
                      Assets.imageYummy,), width: MediaQuery.of(context).size.width/1.3,)),
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 0.w,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 150.w, right: 150.w, bottom: 50.h),
              width: 100.w,
              child: Lottie.network(
                  "https://assets4.lottiefiles.com/packages/lf20_tmnc73b6.json"
              , fit: BoxFit.fill,width: 100.w,),
            ),
          ),
        ],
      ),
    );
  }


}

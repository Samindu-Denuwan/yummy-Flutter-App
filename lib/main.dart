import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/controllers/popular_product_controller.dart';
import 'package:flutter/services.dart';
import 'package:yummy/pages/pages.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/colors.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor:Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
  return  GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return ScreenUtilInit(
          designSize: const Size(360, 780),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Yummy',
              theme: ThemeData(
                primaryColor: AppColors.mainColor,
                fontFamily: 'Poppins',
                useMaterial3: true,
              ),
              //home: SignInPage(),
              initialRoute: RouteHelper.getSplash(),
              getPages: RouteHelper.routes,
            );
          },);

      },);

    },);
  }
}



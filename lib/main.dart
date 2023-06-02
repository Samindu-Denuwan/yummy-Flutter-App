import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/controllers/popular_product_controller.dart';
import 'package:yummy/pages/cart/cart_page.dart';
import 'package:yummy/pages/food/popular_food_detail.dart';
import 'package:yummy/pages/food/recomended_food_detail.dart';
import 'package:flutter/services.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/colors.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'pages/home/main_food_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor:AppColors.buttonBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yummy',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: RouteHelper.getInitial(),
        getPages: RouteHelper.routes,
      );
    },);
  }
}



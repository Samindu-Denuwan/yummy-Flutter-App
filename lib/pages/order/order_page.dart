import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/base/custom_app_bar.dart';
import 'package:yummy/base/custom_signIn.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/pages/pages.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  late TabController _tabController;
  late bool _isLoggedIn;
  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController = TabController(
          length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My Orders", backBtnExist: false),
      backgroundColor: Colors.white,
      body: _isLoggedIn? Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              indicatorColor: AppColors.mainColor,
             unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Poppins'
              ),
              labelColor: AppColors.mainColor,
              labelStyle: const TextStyle(
                  fontFamily: 'Poppins'
              ),
              dividerColor: Colors.white,
              controller: _tabController,
                tabs: const [
                   Tab(text: "Running Orders",),
                   Tab(text: "Order History",),

                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children: const [
                  ViewOrder(isCurrent: true),
                  ViewOrder(isCurrent: false),
                ]
            ),
          ),
        ],
      ) : CustomSignIn(),

    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yummy/base/btn_custom.dart';
import 'package:yummy/base/show_custom_snackbar.dart';
import 'package:yummy/controllers/cart_controller.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/controllers/popular_product_controller.dart';
import 'package:yummy/controllers/recommended_product_controller.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/models/place_order_model.dart';
import 'package:yummy/pages/order/widgets/additional_note.dart';
import 'package:yummy/pages/order/widgets/cutom_toggle.dart';
import 'package:yummy/pages/order/widgets/delivery_option.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_icon.dart';
import 'package:yummy/widgets/app_text_field.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/pages/order/widgets/payment_option_btn.dart';
import 'package:yummy/widgets/small_text.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  static final _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark),
        ),
        body: Stack(
          children: [
            Positioned(
                left: 20.w,
                right: 20.w,
                top: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: AppIcon(
                        icon: Icons.arrow_back_ios_new,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: 22,
                      ),
                    ),
                    AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor),
                  ],
                )),
            GetBuilder<CartController>(
              builder: (cartController) {
                return cartController.getItems.isNotEmpty
                    ? Positioned(
                        top: 100.h,
                        left: 20.w,
                        right: 20.w,
                        bottom: 0,
                        child: Container(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                              builder: (cartController) {
                                var _cartList = cartController.getItems;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      height: 100.h,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);

                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cartPage"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "History Product",
                                                      "Product review is not available for history products.",
                                                      icon: Icon(
                                                        Icons.error,
                                                        size: 30.sp,
                                                        color: Colors.white30,
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      colorText: Colors.white,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.h,
                                                              horizontal:
                                                                  10.w));
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartPage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 90.w,
                                              height: 90.h,
                                              margin:
                                                  EdgeInsets.only(bottom: 10.h),
                                              child: CachedNetworkImage(
                                                imageUrl: AppConstants
                                                        .BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    _cartList[index].img!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 90.w,
                                                  height: 90.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.w),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Lottie.asset(
                                                        Assets
                                                            .animationImageLoading,
                                                        fit: BoxFit.cover),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Image(
                                                  image: AssetImage(
                                                      Assets.imageLoadImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 90.h,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text:
                                                        _cartList[index].name!,
                                                    color: Colors.black54,
                                                  ),
                                                  SmallText(text: "Spicy"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text:
                                                        "\$ ${_cartList[index].price}",
                                                        color: Colors.red,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(20
                                                                            .w),
                                                                color: Colors
                                                                    .white),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w,
                                                                    vertical:
                                                                        10.h),
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    cartController.addItem(
                                                                        _cartList[index]
                                                                            .product!,
                                                                        -1,
                                                                        false);
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: AppColors
                                                                        .signColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 8.w,
                                                                ),
                                                                BigText(
                                                                  text:
                                                                      '${_cartList[index].quantity}',
                                                                ),
                                                                SizedBox(
                                                                  width: 8.w,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    cartController.addItem(
                                                                        _cartList[index]
                                                                            .product!,
                                                                        1,
                                                                        false);
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons.add,
                                                                    color: AppColors
                                                                        .signColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Lottie.asset(Assets.animationEmpty,
                                      fit: BoxFit.cover),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Center(
                                      child: BigText(
                                    text: "No Food Items yet?",
                                    color: Colors.black26,
                                  )),
                                  Center(
                                      child: BigText(
                                    text: "Explore more",
                                    color: Colors.black26,
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<OrderController>(
          builder: (orderController) {
            //_noteController.text = orderController.foodNote;
            return GetBuilder<CartController>(
              builder: (cartController) {
                var _cartList = cartController.getItems;
                return _cartList.isNotEmpty
                    ? Container(
                        height: 120.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.w),
                                topRight: Radius.circular(50.w)),
                            color: AppColors.buttonBackgroundColor),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.w),
                                      color: Colors.white),
                                  child: BigText(
                                      text:
                                      "\$  ${cartController.totalAmount}"),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      if (Get.find<LocationController>()
                                          .addressList
                                          .isEmpty) {
                                        Get.toNamed(
                                            RouteHelper.getAddressPage());
                                      } else {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (_) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.81,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50.w),
                                                    topRight:
                                                        Radius.circular(50.w),
                                                  ),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20.h),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(10
                                                                              .w),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                              width: 50.w,
                                                              height: 5.h,
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          20.w,
                                                                      right:
                                                                          20.w),
                                                              //height: 540.h,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      BigText(
                                                                          text:
                                                                              'Additional Note'),
                                                                      const CustomToggle(),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        10.h,
                                                                  ),
                                                                  AdditionalNotesTextField(
                                                                      textController:
                                                                          _noteController,
                                                                      hintText:
                                                                          "Note Here",
                                                                      icon: Icons
                                                                          .note,
                                                                      inputType:
                                                                          TextInputType
                                                                              .text),
                                                                  BigText(
                                                                      text:
                                                                          'Payment Options'),
                                                                  SizedBox(
                                                                    height:
                                                                        10.h,
                                                                  ),
                                                                  const PaymentOptionBtn(
                                                                      icon: Icons
                                                                          .money,
                                                                      title:
                                                                          "Cash on Delivery",
                                                                      subTitle:
                                                                          "Pay your payement after getting food",
                                                                      index: 0),
                                                                  const PaymentOptionBtn(
                                                                      icon: Icons
                                                                          .paypal,
                                                                      title:
                                                                          "Digital Payment",
                                                                      subTitle:
                                                                          "Faster and safer way to send money",
                                                                      index: 1),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      BigText(
                                                                          text:
                                                                              'Delivery Option'),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Get.toNamed(RouteHelper.getAddressPage());
                                                                            },
                                                                        splashColor: AppColors
                                                                            .mainColor
                                                                            .withOpacity(0.2),
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.location_on,
                                                                                color: AppColors.mainColor,
                                                                              ),
                                                                              SmallText(
                                                                                text: "Set Location",
                                                                                color: Colors.grey.shade500,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  DeliveryOption(
                                                                      value:
                                                                          "delivery",
                                                                      title:
                                                                          "Home Delivery",
                                                                      amount: cartController
                                                                          .totalAmount
                                                                          .toDouble(),
                                                                      isFree:
                                                                          false),
                                                                  DeliveryOption(
                                                                      value:
                                                                          "take away",
                                                                      title:
                                                                          "Take Away",
                                                                      amount: cartController
                                                                          .totalAmount
                                                                          .toDouble(),
                                                                      isFree:
                                                                          true),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        var location = Get.find<
                                                                LocationController>()
                                                            .getUserAddress();
                                                        var cart = Get.find<
                                                                CartController>()
                                                            .getItems;
                                                        var user = Get.find<
                                                                UserController>()
                                                            .userModel;
                                                        PlaceOrderBody
                                                            placeOrder =
                                                            PlaceOrderBody(
                                                          cart: cart,
                                                          orderAmount: 100.0,
                                                          orderNote: orderController.isToggled?(_noteController.text.isNotEmpty
                                                                  ? _noteController.text
                                                                  : "Empty Note")
                                                              : "Empty Note",
                                                          distance: 10.0,
                                                          address:
                                                              location.address,
                                                          latitude:
                                                              location.latitude,
                                                          longitude: location
                                                              .longitude,
                                                          contactPersonName:
                                                              user!.name,
                                                          contactPersonNumber:
                                                              user.phone,
                                                          scheduleAt: '',
                                                          orderType:
                                                              orderController
                                                                  .deliveryType,
                                                          paymentMethod: orderController
                                                                      .paymentIndex ==
                                                                  0
                                                              ? 'cash_on_delivery'
                                                              : 'digital_payment',
                                                        );
                                                        _noteController.clear();

                                                        Get.find<
                                                                OrderController>()
                                                            .placeOrder(
                                                                placeOrder,
                                                                _callback);
                                                      },
                                                      child: BtnCustom(
                                                          color: AppColors
                                                              .mainColor,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          radius: 20,
                                                          isBoxShadow: true,
                                                          bigText: BigText(
                                                            text:
                                                                "Place the Order",
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20.w,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      Get.toNamed(RouteHelper.getSignIn());
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 20.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                        color: AppColors.mainColor),
                                    child: BigText(
                                      text: "Checkout",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 0.h,
                      );
              },
            );
          },
        ));
  }

  void _callback(bool isSuccess, String message, String orderId) {
    print("......Tapped....");
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        //cash on delivery
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderId, 'success'));
      } else {
        //digital payment
        Get.offNamed(RouteHelper.getPaymentPage(
            orderId, Get.find<UserController>().userModel!.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}

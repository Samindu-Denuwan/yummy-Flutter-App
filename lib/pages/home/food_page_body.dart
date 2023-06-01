
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yummy/controllers/popular_product_controller.dart';
import 'package:yummy/controllers/recommended_product_controller.dart';
import 'package:yummy/models/products_model.dart';
import 'package:yummy/pages/food/popular_food_detail.dart';
import 'package:yummy/pages/food/recomended_food_detail.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/app_constants.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_column.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/icon_and_text-widget.dart';
import 'package:yummy/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220.h;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Popular Slider Section
        GetBuilder<PopularProductController>(
            builder: (popularProducts) {
          return popularProducts.isLoaded?Container(
            height: 320.h,
            child: PageView.builder(
              controller: pageController,
              itemCount: popularProducts.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(
                    position,popularProducts.popularProductList[position] );
              },
            ),
          ) : const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //Dots Indicator
        GetBuilder<PopularProductController>(
            builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1: popularProducts.popularProductList.length,
            position: _currPageValue.round(),
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: AppColors.mainColor,
            ),
          );
        }),
        SizedBox(height: 20.h),
        //Recommended Text
        Container(
          margin: EdgeInsets.only(left: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             BigText(text: "Recommended"),
             SizedBox(width: 10.w,),
            Container(
              margin: EdgeInsets.only(bottom: 3.h),
              child: BigText(text: ".", color: Colors.black26,),
            ),
             SizedBox(width: 10.w,),
             Container(
               margin: EdgeInsets.only(bottom: 3.h),
               child: SmallText(text: "Food Pairing"),
             ),
           ],
          ),
        ),
        SizedBox(height: 20.h),
        //Recommended List
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProduct) {
              return ListView.builder(
                physics:  const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context, index) {
                  return recommendedProduct.isLoaded?GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                      child: Row(
                        children: [
                          //image Container
                          Container(
                            width:100.w,
                            height:100.h,
                            decoration: BoxDecoration(
                                image:  DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20.w),
                                color: Colors.white38
                            ),
                          ),
                          //Text Container
                          Expanded(
                            child: Container(
                              height: 95.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15.w),
                                    bottomRight: Radius.circular(15.w)),
                                color: Colors.white,


                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                    SizedBox(height: 10.h,),
                                    SmallText(text: "with chocolate moose"),
                                    SizedBox(height: 10.h,),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(
                                            text: "Normal",
                                            icon: Icons.circle_sharp,
                                            iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(
                                            text: "1.7km",
                                            icon: Icons.location_on,
                                            iconColor: AppColors.mainColor),
                                        IconAndTextWidget(
                                            text: "32min",
                                            icon: Icons.access_time_rounded,
                                            iconColor: AppColors.iconColor2),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ): const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
                },);
            },),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: 220.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: index.isEven ? Colors.yellow : Colors.blue,
                  image:  DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!),
                  ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120.h,
              margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 40.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                child: AppColumn(text: popularProduct.name!, stars: popularProduct.stars!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/icon_and_text-widget.dart';
import 'package:yummy/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../utils/dimensions.dart';
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
        //Slider Section
        Container(
          height: 320.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        //Dots Indicator
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue.round(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeColor: AppColors.mainColor,
          ),
        ),
        SizedBox(height: 20.h),
        //Popular Text
        Container(
          margin: EdgeInsets.only(left: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             BigText(text: "Popular"),
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
        //Popular List
        ListView.builder(
          physics:  NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Row(
                children: [
                  //image Container
                  Container(
                    width:100.w,
                    height:100.h,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                            image: AssetImage("assets/image/food0.png")),
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
                              BigText(text: "Sweet Dessert Dessert"),
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
            );
          },),
      ],
    );
  }

  Widget _buildPageItem(int index) {
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
          Container(
            height: 220.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: index.isEven ? Colors.yellow : Colors.blue,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/food0.png'))),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Chinese Side"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 15.sp,
                                  )),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SmallText(
                          text: "4.5",
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SmallText(
                          text: "1287",
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SmallText(
                          text: "comments",
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

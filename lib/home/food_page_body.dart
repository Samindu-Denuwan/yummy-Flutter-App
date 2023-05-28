import 'package:flutter/material.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/icon_and_text-widget.dart';
import 'package:yummy/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
      viewportFraction: 0.85
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: PageView.builder(
        controller: pageController,
        itemCount: 5,
          itemBuilder: (context, position) {
                return _buildPageItem(position);
          },),
    );
  }
}

Widget _buildPageItem(int index) {
  return Stack(
    children: [
      Container(
        height: 220,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: index.isEven?Colors.yellow: Colors.blue,
          image: const DecorationImage(
            fit: BoxFit.cover,
              image: AssetImage('assets/image/food0.png'))
        ),


      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 130,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 1
              )
            ]

          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: "Chinese Side"),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(5, (index) =>
                          const Icon(Icons.star, color: AppColors.mainColor,size: 15,)),
                    ),
                    const SizedBox(width: 10,),
                    SmallText(text: "4.5", color: Colors.grey, ),
                    const SizedBox(width: 10,),
                    SmallText(text: "1287", color: Colors.grey, ),
                    const SizedBox(width: 10,),
                    SmallText(text: "comments", color: Colors.grey, ),

                  ],
                ),
                const SizedBox(height: 20,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     IconAndTextWidget(text: "Normal",
                        icon: Icons.circle_sharp,
                        iconColor: AppColors.iconColor1),
                    IconAndTextWidget(text: "1.7km",
                        icon: Icons.location_on,
                        iconColor: AppColors.mainColor),
                    IconAndTextWidget(text: "32min",
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
  );
}

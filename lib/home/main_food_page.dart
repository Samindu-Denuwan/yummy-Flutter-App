import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yummy/home/food_page_body.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            systemNavigationBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Container(
              margin: const EdgeInsets.only(top:15, bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BigText(text: "Sri Lanka", color: AppColors.mainColor,),
                      Row(
                        children: [
                          SmallText(text: "Seeduwa", color: Colors.black54,),
                          const Icon(Icons.arrow_drop_down, color: AppColors.mainBlackColor,),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.mainColor),
                      child: const Icon(Icons.search, color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FoodPageBody()
        ],
      ),
    );
  }
}

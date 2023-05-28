import 'package:flutter/material.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/icon_and_text-widget.dart';
import 'package:yummy/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
      viewportFraction: 0.85
  );
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

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
        Container(
          height: 320,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },),
        ),
    DotsIndicator(
    dotsCount: 5,
    position: _currPageValue.round(),
    decorator: DotsDecorator(
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      activeColor: AppColors.mainColor,
    ),
    )
      ],
    );
  }


  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if(index == _currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans  = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans  = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans  = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      var currTrans  = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 220,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Colors.yellow : Colors.blue,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/food0.png'))
            ),


          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 130,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const[
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        offset:  Offset(0, 5),
                        blurRadius: 5,

                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset:  Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset:  Offset(5, 0),
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
                          const Icon(Icons.star, color: AppColors.mainColor,
                            size: 15,)),
                        ),
                        const SizedBox(width: 10,),
                        SmallText(text: "4.5", color: Colors.grey,),
                        const SizedBox(width: 10,),
                        SmallText(text: "1287", color: Colors.grey,),
                        const SizedBox(width: 10,),
                        SmallText(text: "comments", color: Colors.grey,),

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
      ),
    );
  }

}

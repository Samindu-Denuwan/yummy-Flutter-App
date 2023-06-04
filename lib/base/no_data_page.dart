import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yummy/widgets/small_text.dart';

import '../generated/assets.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({Key? key,
    required this.text,
    this.imgPath = Assets.imageEmptyCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(imgPath,
        height: MediaQuery.of(context).size.height*0.22,
        width: MediaQuery.of(context).size.height*0.22,),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Center(child: SmallText(text: text, size: 14, color: Colors.black54,))

      ],

    );
  }
}

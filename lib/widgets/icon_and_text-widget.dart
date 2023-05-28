import 'package:flutter/material.dart';
import 'package:yummy/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;


  const IconAndTextWidget({Key? key,
    required this.text,
    required this.icon,
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
         Icon(icon, color: iconColor,),
        const SizedBox(width: 5,),
        SmallText(text: text)
      ],
    );
  }
}

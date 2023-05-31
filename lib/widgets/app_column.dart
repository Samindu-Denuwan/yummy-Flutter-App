import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/icon_and_text-widget.dart';

import 'package:yummy/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  TextOverflow overflow;
  final int stars;

   AppColumn({Key? key, required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 18,
     required this.stars,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: 1,
          overflow: overflow,
          style: TextStyle(
              fontSize: size.sp,
              color: color,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  stars,
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
              text: '$stars',
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool backBtnExist;
  final Function? onBackPress;
  const CustomAppBar({Key? key, 
    required this.title, 
    this.backBtnExist = true, 
    this.onBackPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(text: title, color: Colors.white, size: 19,),
      centerTitle: true,
      backgroundColor: AppColors.mainColor,
      leading: backBtnExist? IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
        onPressed:()=>onBackPress!=null? onBackPress!()
            :Navigator.pushReplacementNamed(context, '/'),
      ):const SizedBox(),

      
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size(500.w, 55.h);
}

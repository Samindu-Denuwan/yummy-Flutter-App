import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 140.h;

  @override
  void initState() {
    super.initState();
    if(widget.text.length>textHeight ){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(
          textHeight.toInt()+1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty? SmallText(text: firstHalf):
      Expanded(

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(bottom: 130.h),

          child: Column(
            children: [
              SmallText(text: hiddenText?("$firstHalf...") :
                  firstHalf+ secondHalf,size: 13, height: 1.7, color: Colors.grey.shade500,
              ),
              InkWell(
                child: Row(
                  children: [
                    SmallText(text: "Show more", color: AppColors.mainColor,),
                     Icon(hiddenText?Icons.arrow_drop_down: Icons.arrow_drop_up, color: AppColors.mainColor,),
                  ],
                ),
                onTap: (){
                  setState(() {
                    hiddenText=! hiddenText;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

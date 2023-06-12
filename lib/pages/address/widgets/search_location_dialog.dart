import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:google_maps_webservice/src/places.dart';


class LocationDialog extends StatelessWidget {
  final GoogleMapController mapController;
  LocationDialog({Key? key, required this.mapController}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical:40.h ),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
                autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              style:  TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Colors.black.withOpacity(0.7),
              ),
              maxLines: 1,
              cursorColor: AppColors.mainColor,
              decoration: InputDecoration(
                hintText: "search location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.w),
                      borderSide: BorderSide(
                        style: BorderStyle.none, width: 0,
                      ),
                    ),
              )

            ),
              onSuggestionSelected: (Prediction suggestion) {
                 Get.find<LocationController>().setLocation(suggestion.placeId!,
                    suggestion.description!, mapController);
                 Get.back();
              },

              suggestionsCallback: (pattern) async {
                 return await Get.find<LocationController>().searchLocation(context, pattern);
              },
              itemBuilder: (context, Prediction suggestion) {
                return Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.mainColor,),
                      SizedBox(width: 10.w,),
                      Expanded(
                          child: Text(suggestion.description!,
                            overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,


                          ),),)
                    ],
                  ),
                );

              },
             ),
        ),
      ),
    );
  }
}

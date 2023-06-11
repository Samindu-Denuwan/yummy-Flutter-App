import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yummy/base/btn_custom.dart';
import 'package:yummy/base/circular_loader.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/generated/assets.dart';
import 'package:yummy/routes/route_helper.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';
import 'package:yummy/widgets/custom_btn.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({Key? key,
    required this.fromSignUp,
    required this.fromAddress,
    this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = const
      LatLng(7.132988527485233, 79.88856944968506);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(Get.find<LocationController>().getAddress['longitude']));
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);

      print("LatLng......."+_initialPosition.toString());

      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                 padding: EdgeInsets.only(top: 150.h),
                  initialCameraPosition:CameraPosition(
                      target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition){
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: (){
                    Get.find<LocationController>().updatePosition(
                        _cameraPosition, false);
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,

                ),
                Center(
                  child: !locationController.loading?Image.asset(Assets.imagePin,
                  height: 50.h, width: 50.w,): const CircularLoader(),
                ),
                Positioned(
                  top: 70.h,
                    left: 20.w,
                    right: 20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white,size: 25.sp,),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              scrollDirection: Axis.horizontal,
                                child: BigText(text: '${locationController.pickPlacemark.name?? ""}', color: Colors.white, size: 16.sp,)),
                          ),
                        ],
                      ),

                    )),
                Positioned(
                  bottom: 80.h,
                  left: 20.w,
                  right: 20.w,
                    child: locationController.isLoading? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),): CustomBtn(
                      radius: 30,
                      width: 200,
                      height:60,
                      bigText: BigText(text:locationController.inZone?widget.fromAddress? "Set Address": "Set Location":"Not Available", color: Colors.white,),
                      onPressed: (locationController.buttonDisabled||locationController.loading)? null: (){
                        if(locationController.pickPosition.latitude!=0 && locationController.pickPlacemark.name!= null){
                          if(widget.fromAddress){
                            if(widget.googleMapController!=null){

                              widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(locationController.pickPosition.latitude,
                                      locationController.pickPosition.longitude)
                              ) ));
                              locationController.setAddAddressData();
                              print("................"+locationController.pickPlacemark.name!);

                            }
                            Get.back();
                            //Get.offNamed(RouteHelper.getAddressPage());
                          }

                        }
                      },
                    ),

                ),
              ],
            ),
          ),
        ),

      );
    },);
  }
}

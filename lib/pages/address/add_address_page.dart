import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/models/user_model.dart';
import 'package:yummy/utils/colors.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
   CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(7.217062, 79.861960), zoom:17 );
late LatLng _initialPosition = LatLng(7.217062, 79.861960);


@override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(Get.find<LocationController>().getAddress["latitude"]),
               double.parse(Get.find<LocationController>().getAddress["longitude"])
          )
      );
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            children: [
              Container(
                height: 140.h,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor
                  )
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                        initialCameraPosition: CameraPosition
                          (target: _initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position)=>_cameraPosition),
                    onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                      },)
                  ],
                ),

              )
            ],
          );
        }
      ),
    );
  }
}


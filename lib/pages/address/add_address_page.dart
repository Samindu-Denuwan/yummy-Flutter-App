import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yummy/base/show_custom_snackbar.dart';
import 'package:yummy/controllers/controllers.dart';
import 'package:yummy/models/address_model.dart';
import 'package:yummy/models/user_model.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/app_text_field.dart';
import 'package:yummy/widgets/big_text.dart';

import '../../routes/route_helper.dart';

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
      target: LatLng(7.132988527485233, 79.88856944968506), zoom: 17);
  late LatLng _initialPosition =
      const LatLng(7.132988527485233, 79.88856944968506);

  @override
  void initState() {
    super.initState();
    print("localStorage address:.........."+Get.find<LocationController>().getUserAddressFromLocalStorage().toString());
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {

     if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
       Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
     }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BigText(
          text: "Add Address",
          color: Colors.white,
          fontWeight: FontWeight.w500,
          size: 20,
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel?.name}';
            _contactPersonNumber.text = '${userController.userModel?.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              print("Address list..."+Get.find<LocationController>().addressList.toString());
              _addressController.text =Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(builder: (locationController) {
            _addressController.text =
                '${locationController.placemark.name ?? ""}'
                '${locationController.placemark.locality ?? ""}'
                '${locationController.placemark.postalCode ?? ""}'
                '${locationController.placemark.country ?? ""}';
            print("Address in my view:...." + _addressController.text);
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 10.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140.h,
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.w),
                        border:
                            Border.all(width: 2, color: AppColors.mainColor)),
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: _initialPosition, zoom: 17),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          onCameraIdle: () {
                            locationController.updatePosition(
                                _cameraPosition, true);
                          },
                          onCameraMove: ((position) =>
                              _cameraPosition = position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                            if (Get.find<LocationController>()
                                .addressList
                                .isEmpty) {
                              // locationController.getCurrentLocation(true, mapController: controller);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.w),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ]),
                              child: Icon(
                                index == 0
                                    ? Icons.home_filled
                                    : index == 1
                                        ? Icons.work
                                        : Icons.location_on,
                                color:
                                    locationController.addressTypeIndex == index
                                        ? AppColors.mainColor
                                        : Theme.of(context).disabledColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BigText(text: "Delivery Address"),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextField(
                      textController: _addressController,
                      hintText: "Your Address",
                      icon: Icons.location_on,
                      inputType: TextInputType.text),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BigText(text: "Your Name"),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextField(
                      textController: _contactPersonName,
                      hintText: "Your Name",
                      icon: Icons.person,
                      inputType: TextInputType.text),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BigText(text: "Your Phone Number"),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextField(
                      textController: _contactPersonNumber,
                      hintText: "Your Phone Number",
                      icon: Icons.phone,
                      inputType: TextInputType.phone),
                ],
              ),
            );
          });
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return GestureDetector(
            onTap: () {
              AddressModel _addressModel = AddressModel(
                  addressType: locationController
                      .addressTypeList[locationController.addressTypeIndex],
                  contactPersonName: _contactPersonName.text,
                  contactPersonNumber: _contactPersonNumber.text,
                  address: _addressController.text,
                  latitude: locationController.position.latitude.toString(),
                  longitude: locationController.position.longitude.toString());
              locationController.addAddress(_addressModel).then((response) {
                if (response.isSuccess) {
                  Get.toNamed(RouteHelper.getInitial());
                  showCustomSnackBar("Added Successfully",
                      title: "Address",
                      isError: false,
                      icon: Icons.check_circle,
                      color: Colors.green);
                } else {
                  showCustomSnackBar("Couldn't save the address");
                }
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
              width: 150.w,
              height: 60.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: AppColors.mainColor),
              child: Center(
                  child: BigText(
                text: "Save Address",
                color: Colors.white,
              )),
            ),
          );
        },
      ),
    );
  }


}

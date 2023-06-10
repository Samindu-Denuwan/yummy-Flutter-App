import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yummy/base/show_custom_snackbar.dart';
import 'package:yummy/data/repository/repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:yummy/models/address_model.dart';
import 'package:yummy/models/response_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;
  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }



  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.latitude,
              latitude: position.target.longitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.latitude,
              latitude: position.target.longitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
            LatLng(position.target.latitude, position.target.longitude),
          );
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
          //  print("Street...."+_placemark.street.toString());
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknown location Found";
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]['formatted_address'].toString();
      // print("Printing Address:......$_address");
    } else {
      print("ERROR:............${response.body["error_message"]}");
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e.toString());
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
     await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
     await saveUserAddress(addressModel);
    } else {
      print("Couldn't Save the Address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
   Response response = await locationRepo.getAllAddress();
   if(response.statusCode==200){
      _addressList =[];
      _allAddressList=[];
      response.body.forEach((address){
              _addressList.add(AddressModel.fromJson(address));
              _allAddressList.add(AddressModel.fromJson(address));
      });
   }else{
     _addressList =[];
     _allAddressList=[];
   }
   update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }
}

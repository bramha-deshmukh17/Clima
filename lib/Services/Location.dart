import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location{

  late double latitude, longitude;

  Future<void> geoCurrentLocation() async {

   try{
     Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.low);
     latitude = position.latitude;
     longitude = position.longitude;
   }catch(e){
     print(e);
   }
  }
}
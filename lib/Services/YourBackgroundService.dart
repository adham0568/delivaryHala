import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivaryhalaapp/widget/MapModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';



bool locationGet = false;
LatLng? myLocation1;

Future<void> initializeService() async {

  final service =FlutterBackgroundService();
  await service.configure(iosConfiguration: IosConfiguration(
    autoStart: true,
    onForeground: onStart,
    onBackground: onIosBackground,

  ),
      androidConfiguration: AndroidConfiguration(onStart: onStart, isForegroundMode: true,autoStart: true));
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();




  if(service is AndroidServiceInstance){
    await Firebase.initializeApp();
    final stream = DelivaryStateStream();
    stream.listen((numValue) async {
      if (numValue != null && numValue == 1) {
       await EditLocation();
       /* print('Value of Num: $numValue');
        print(myLocation1);*/
      } else {
/*
        print(0);
*/
      }
    });


    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
Timer.periodic(Duration(seconds: 3), (timer) async {
  await getMyLocation();
});

  service.invoke('update');
  }

  Future<Position> detrmineLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permission denied'); // طرح استثناء في حالة حدوث خطأ
      }
    }
    return await Geolocator.getCurrentPosition();
  }


  Future<void> getMyLocation() async {
    Position myLocation = await detrmineLocation();
    myLocation1 = LatLng(myLocation.latitude, myLocation.longitude);
    myLocation1 == null ? locationGet = false : locationGet = true;
  }







Stream<int?> DelivaryStateStream() {
  try {
    return FirebaseFirestore.instance
        .collection('UpdateLocation')
        .doc('City1')
        .snapshots()
        .map<int?>((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final numValue = data['Update'] as int?;
        return numValue;
      } else {
/*
        print('Document not found');
*/
        return null; // إذا لم يتم العثور على المستند
      }
    });
  } catch (e) {

    return Stream.empty(); // في حالة حدوث خطأ
  }
}


EditLocation() async {
  try{
    await FirebaseFirestore.instance.collection('DilevaryHala').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'Location':GeoPoint(myLocation1!.latitude,myLocation1!.longitude),
    });
    print('تم تحديث الموقع الحالي ');

    //__________________________________ afterUpdateLocationWait 3 Secandes And Back Value 0 _________________________________________________

  }
  catch(e){print(e);}
}



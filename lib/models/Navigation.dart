import 'dart:convert';
import 'package:delivaryhalaapp/widget/SnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';


class lunchGoogleMap{
  void openGoogleMaps({required LatLng Location}) async {
    final title = "Location";

    await MapsLauncher.launchCoordinates(
      Location.latitude,
      Location.longitude,
    );
  }
}

class lunchWaze {
  double LatLocation;
  double LngLocation;

  lunchWaze({required this.LatLocation,required this.LngLocation});

  final String destinationAddress = "العنوان الهدف هنا";

  // إحداثيات النقطة الهدف
  late final double destinationLatitude = LatLocation;
  late final double destinationLongitude = LngLocation;

  // رسالة الخطأ
  final String errorMessage = "لا يمكن العثور على تطبيق Waze.";

  // رسالة نجاح العملية
  final String successMessage = "تم فتح تطبيق Waze بنجاح.";

  // تفاصيل النقطة الهدف
  String get destinationDetails =>
      "$destinationAddress\n$destinationLatitude, $destinationLongitude";

  // رابط التنقل إلى Waze مع تفاصيل النقطة الهدف
  String get wazeUrl =>
      "waze://?ll=$destinationLatitude,$destinationLongitude&navigate=yes";

  // فتح تطبيق Waze إذا تم تثبيته
  Future<void> launchWaze({required BuildContext context}) async {
    final url = wazeUrl;

    if (await canLaunch(url)) {
      await launch(url);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(successMessage),
          content: Text(destinationDetails),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      Navigator.pop(context);
    } else {
      showSnackBar(context: context, text: 'حدث خطأ حاول مرة اخرى', color1: Colors.red);
      Navigator.pop(context);

    }
  }
}





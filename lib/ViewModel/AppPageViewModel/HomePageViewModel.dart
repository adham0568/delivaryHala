import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../View/AppPage/talabat.dart';
import '../../provider/DataUser.dart';

class HomePageVM extends ChangeNotifier{
  Userdata? userdata;
  bool _downloadData=false;
  bool get downloadData => _downloadData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get ScaffoldKey =>_scaffoldKey;
  List Ordar=[];
  getDataFromDB(BuildContext context) async {
    Userdata userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    _downloadData=true;
    notifyListeners();
  }



  initalMessage(BuildContext context) async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null && message.notification != null && message.notification!.body == 'لديك طلب جديد') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Talabat(),));
    } else {
      print('null');
    }
  }



 messagingOnOpenApp(BuildContext context){
   FirebaseMessaging.onMessageOpenedApp.listen((event) {
     if(event.notification!.body=='لديك طلب جديد'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => Talabat(),));
     }
   });
 }

}
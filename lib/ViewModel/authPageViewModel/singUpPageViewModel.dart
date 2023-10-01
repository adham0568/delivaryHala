import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class singUpViewModel with ChangeNotifier{
  final Email=TextEditingController();
  final Password=TextEditingController();
  final Name=TextEditingController();
  final Phone=TextEditingController();
  var fbm=FirebaseMessaging.instance;
  bool showPssword=true;
  String token='';
  double H= 0;
  double W=0;

  TextStyle myTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize:0,
  );

  getToken(){
    fbm.getToken().then((Token){
      token=Token!;
    });
    notifyListeners();
  }
  getSizeSecreen(BuildContext context){
    H=MediaQuery.of(context).size.height;
    W=MediaQuery.of(context).size.width;
    myTextStyle =TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: W / 18,
    );
  }
}
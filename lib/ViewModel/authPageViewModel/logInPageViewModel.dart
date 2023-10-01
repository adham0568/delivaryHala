import 'package:flutter/material.dart';

class logInPageViewModel{
  double H= 0;
  double W=0;

  final Email=TextEditingController();
  final Password=TextEditingController();
  bool showPssword=true;



  getSizeSecreen(BuildContext context){
    H=MediaQuery.of(context).size.height;
    W=MediaQuery.of(context).size.width;
  }

}
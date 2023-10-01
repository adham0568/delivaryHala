import 'package:flutter/material.dart';

class myAppTheme{
  TextStyle textStyle=TextStyle(fontSize:0,color: Colors.white,fontWeight: FontWeight.bold);

  double H=0;
  double W=0;
  Color color1= Colors.blueAccent;
  Color color2=  Colors.purple;
  Decoration decrotion1=BoxDecoration(
   borderRadius: BorderRadius.circular(15),
   gradient: LinearGradient(
     begin: Alignment.topRight,
     end: Alignment.bottomLeft,
     colors: [Colors.blueAccent,Colors.purple]
   ));
  getSizePhone(BuildContext context){
    H=MediaQuery.of(context).size.height;
    W=MediaQuery.of(context).size.width;
    textStyle=TextStyle(fontSize:W/20,color: Colors.white,fontWeight: FontWeight.bold);

 }
}
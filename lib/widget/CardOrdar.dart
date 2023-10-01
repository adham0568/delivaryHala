

import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/widget/Botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/AppPage/talabatDetales.dart';

class CardOrderWidget extends StatefulWidget {
  Map DataOrdar;
  CardOrderWidget({required this.DataOrdar,Key? key}) : super(key: key);

  @override
  State<CardOrderWidget> createState() => _CardOrderWidgetState();
}

class _CardOrderWidgetState extends State<CardOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: themeApp.H/4,
          margin: EdgeInsets.symmetric(horizontal: themeApp.W/40,vertical: themeApp.H/20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:[
                    Colors.blueAccent,
                    Colors.purple,
                  ]
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(50),topLeft: Radius.circular(50),topRight: Radius.circular(15))
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  bottom: 15,
                  right: themeApp.W/100,
                  left: themeApp.W/5,
                  child: Container(child: Image.asset('assets/Img/Logo.png',fit: BoxFit.cover,color: Colors.white12,),)),
              Positioned(
                right:themeApp.W/35,
                top: themeApp.H/50,
                child: Container(
                  width: themeApp.W/2.2,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(widget.DataOrdar['Name'],style:themeApp.textStyle)),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(widget.DataOrdar['MarketName'],style:themeApp.textStyle)),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text('(${widget.DataOrdar['items'].length}) عدد الاصناف',style:themeApp.textStyle)),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text('(${widget.DataOrdar['PriseOrdar'].length}) السعر',style:themeApp.textStyle)),
                    ],
                  ),
                ),
              ),
              Positioned(
                left:themeApp.W/200,
                top: themeApp.H/50,
                child: Container(
                  width: themeApp.W/2.2,
                  child: Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          showDialog(context: context, builder: (context) =>
                             AlertDialog(
                               backgroundColor: Colors.black54,
                                 content:
                             Container(
                               height: themeApp.H/4,
                               width: themeApp.W*0.9,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Text('هل انت متاكد من قبول الطلب',style:themeApp.textStyle,),
                                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       Bottom(function: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => TalabatDetals(OrdarData: widget.DataOrdar),));
                                       }, textcolor: Colors.white, color1: themeApp.color1, color2: Colors.green, text: 'نعم', h: themeApp.H/17, w: themeApp.W/3.5, fontSize: themeApp.W/20),
                                       Bottom(function: (){
                                         Navigator.pop(context);
                                       }, textcolor: Colors.white, color1: Colors.red, color2: Colors.purple, text: 'لا', h: themeApp.H/17, w: themeApp.W/3.5, fontSize: themeApp.W/20),

                                     ],)
                                 ],
                               ),
                             )
                             ),);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: themeApp.W/15),
                          padding: EdgeInsets.symmetric(vertical: themeApp.H/1000),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.green.withOpacity(0.8),
                                    Colors.blueAccent.withOpacity(0.5),
                                  ]
                              )
                          ),
                          child: Center(
                              child: Text('قبول',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/20),)
                          ),
                        ),
                      ),
                      SizedBox(height: themeApp.H/50,),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                         showDialog(context: context, builder: (context) =>
                          AlertDialog(
                            backgroundColor: Colors.black54,
                            content:  Container(
                              height: themeApp.H/4,
                              width: themeApp.W*0.9,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('هل انت متاكد من رفض الطلب',style: themeApp.textStyle,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Bottom(function: (){
                                      }, textcolor: Colors.white, color1: themeApp.color1, color2: Colors.green, text: 'نعم', h: themeApp.H/17, w: themeApp.W/3.5, fontSize: themeApp.W/20),
                                      Bottom(function: (){
                                        Navigator.pop(context);
                                      }, textcolor: Colors.white, color1: Colors.red, color2: Colors.purple, text: 'لا', h: themeApp.H/17, w: themeApp.W/3.5, fontSize: themeApp.W/20),

                                    ],)
                                ],
                              ),
                            ),
                          ),);
                       },
                       child: Container(
                         margin: EdgeInsets.symmetric(horizontal: themeApp.W/15),
                         padding: EdgeInsets.symmetric(vertical: themeApp.H/1000),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           gradient: LinearGradient(
                             begin: Alignment.topRight,
                             end: Alignment.bottomLeft,
                             colors: [
                               Colors.pink.shade700,
                               Colors.pinkAccent.withOpacity(0.8),
                             ]
                           )
                         ),
                         child: Center(
                           child: Text('رفض',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/20),)
                         ),
                       ),
                     ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: themeApp.W/20,
            child: Container(
              width: themeApp.W/7,
              height: themeApp.W/7,
              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.deepOrange.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0,5),
                        spreadRadius: 1,
                        blurStyle: BlurStyle.normal,
                        blurRadius: 7
                    )
                  ]
              ),
              child: Center(
                child:Align(
                    alignment: Alignment.center,
                    child: Text('${widget.DataOrdar['PriseDelivary']}'+'₪',style: TextStyle(color: Colors.white,fontSize: themeApp.W/23,fontWeight: FontWeight.bold),)),
              ),
            ))
      ],
    ) ;
  }
}
/*   ,*/
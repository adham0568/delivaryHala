import 'package:delivaryhalaapp/widget/SwipButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

class Bottom extends StatefulWidget {
  Function function;
  String text;
  Color color1;
  Color color2;
  Color textcolor;
  double w;
  double h;
  double fontSize;
  Bottom({Key? key,required this.function,required this.textcolor,required this.color1,required this.color2,required this.text,required this.h,required this.w,required this.fontSize}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap:(){widget.function();},
      child: Container(
        width: widget.w,
        height: widget.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              widget.color1,
              widget.color2,
            ]
          ),
          borderRadius: BorderRadius.circular(15)
        ),
      child: Center(child: Text(widget.text,style: TextStyle(fontWeight:FontWeight.bold,fontSize:widget.fontSize,color: widget.textcolor),)),
      ),
    );
  }
}








class swipButton extends StatefulWidget {
  const swipButton({Key? key}) : super(key: key);

  @override
  State<swipButton> createState() => _swipButtonState();
}

class _swipButtonState extends State<swipButton> {
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return SwipButton(
      height: h/13,
      borderRadius: w/10,
      iconSize: w/18,
      text: 'التالي',
      width: 400,
      dragableIconBackgroundColor: Colors.greenAccent,
      textStyle: TextStyle(color: Colors.white,fontSize: 15),
      backgroundColor:Colors.green,
      onSubmit: (){
        print('adham');
      },
      gradient:  const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueAccent,
            Colors.purple,
          ]
      ),
    )
    ;
  }
}




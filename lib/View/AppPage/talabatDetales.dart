import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/widget/MapModel.dart';
import 'package:flutter/material.dart';

import '../../ViewModel/AppPageViewModel/talabatDetalsVM.dart';

class TalabatDetals extends StatefulWidget {
  Map OrdarData;
  TalabatDetals({Key? key,required this.OrdarData}) : super(key: key);

  @override
  State<TalabatDetals> createState() => _TalabatDetalsState();
}

class _TalabatDetalsState extends State<TalabatDetals> {
  var dataTalabat=talabatDetales();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(height: themeApp.H,width: themeApp.W,child:MapLocation(OrdarData: widget.OrdarData,whichPage: false),)
          ],
        ),
      ),
    );
  }
}

import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/widget/CardOrdar.dart';
import 'package:delivaryhalaapp/ViewModel/AppPageViewModel/talabatModelView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/DataUser.dart';

class Talabat extends StatefulWidget {
  Talabat({Key? key}) : super(key: key);

  @override
  State<Talabat> createState() => _TalabatState();
}

class _TalabatState extends State<Talabat> {

  var talabatMV=talabatModelView();

  @override
  void initState() {
    talabatMV.getDataFromDB(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    talabatMV.Ordars=DataUser!.Ordar;


    return talabatMV.DownloadData? Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors:[
                 themeApp.color1,
                  themeApp.color2
                ]
            ),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: themeApp.H,
        color: Colors.black12,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width:themeApp.W,
                margin: EdgeInsets.only(top: themeApp.H/50),
                child: Center(child: Text('الطلبات الحالية',style: TextStyle(color: Colors.black54,fontSize: themeApp.W/19,fontWeight: FontWeight.bold),)),
              ),
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:talabatMV.Ordars.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      CardOrderWidget(DataOrdar:talabatMV.Ordars[index]),),
              )
            ],
          ),
        ),
      ),
    ):Container(height: themeApp.H,width: themeApp.H,color: Colors.white,child: Center(child: CircularProgressIndicator(),),);
  }
}

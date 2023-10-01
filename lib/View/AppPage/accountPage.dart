import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/View/AppPage/homePage.dart';
import 'package:delivaryhalaapp/widget/Botton.dart';
import 'package:delivaryhalaapp/ViewModel/AppPageViewModel/accountPageVM.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/DataUser.dart';

class accountPage extends StatefulWidget {
  const accountPage({Key? key}) : super(key: key);

  @override
  State<accountPage> createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  @override
  Widget build(BuildContext context) {
    var dataAccountPage=accountPageVM(context: context);
    final _provider=dataAccountPage.Provideer.getUser;
    return Scaffold(
      body:  CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: themeApp.H/2.5,
                              width: themeApp.W,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors:[
                                      Colors.blueAccent,
                                      Colors.purple,
                                    ]
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('بياناتي',style: TextStyle(fontSize: themeApp.W/18,color: Colors.white,fontWeight: FontWeight.bold),),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_provider!.Name,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                        Text(': الاسم',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_provider!.OrdarDone.length.toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                        Text(': عدد الطلبات المكتملة',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_provider!.feildOrdar.toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                        Text(': عدد الطلبات غير مكتملة',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('₪ '+_provider!.Prifit.toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                        Text(': المبلغ المستحق',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_provider!.PhoneNumber,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                        Text(': رقم الهاتف',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: themeApp.W/18),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: themeApp.H/25,),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _provider!.OrdarDone.length,
                              itemBuilder: (context, index) {
                                return Container(

                                );
                              },)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            expandedHeight: themeApp.H/2.2,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child:InkWell(
                borderRadius: BorderRadius.circular(105),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,boxShadow:[
                    BoxShadow(
                      color: Colors.red,
                      blurStyle: BlurStyle.inner,
                      spreadRadius: 2,
                      offset: Offset(1,3),
                      blurRadius: 100
                    ),]),
                  child: Center(
                    child:Icon(
                      CupertinoIcons.back,color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: themeApp.W/25),
                child: InkWell(
                  borderRadius: BorderRadius.circular(105),
                  onTap: () {

                  },
                  child: Container(
                    padding: EdgeInsets.all(themeApp.W/55),
                    decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,boxShadow:[
                      BoxShadow(
                          color: Colors.red,
                          blurStyle: BlurStyle.inner,
                          spreadRadius: 2,
                          offset: Offset(1,3),
                          blurRadius: 100
                      ),]),
                    child: Center(
                      child:Icon(
                      Icons.edit,color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: themeApp.W*0.9,
                      height: themeApp.H/5,
                      decoration:themeApp.decrotion1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_provider!.OrdarDone[index]['OrdarId'].toString(),style: themeApp.textStyle,),
                                Text(_provider!.OrdarDone[index]['MarketName'].toString(),style: themeApp.textStyle,),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_provider!.OrdarDone[index]['PriseOrdar'].toString(),style: themeApp.textStyle,),
                                Text(_provider!.OrdarDone[index]['Name'].toString(),style: themeApp.textStyle,),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_provider!.OrdarDone[index]['PriseDelivary'].toString()+' ₪',style: themeApp.textStyle,),
                                Text('سعر التوصيل',style: themeApp.textStyle,),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: themeApp.W/10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat.yMd().add_jm().format(_provider.OrdarDone[index]['Time'].toDate()).toString(),style: themeApp.textStyle,),
                                Text('التاريخ',style: themeApp.textStyle,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                );
              },
              childCount: _provider!.OrdarDone.length,
            ),
          ),
        ],
      ),
    );
  }
}

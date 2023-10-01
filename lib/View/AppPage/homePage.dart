import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivaryhalaapp/widget/Botton.dart';
import 'package:delivaryhalaapp/models/FirebaseStatment.dart';
import 'package:delivaryhalaapp/widget/onoffbutton.dart';
import 'package:delivaryhalaapp/View/authPages/LogInPage.dart';
import 'package:delivaryhalaapp/View/AppPage/accountPage.dart';
import 'package:delivaryhalaapp/View/AppPage/talabat.dart';
import 'package:delivaryhalaapp/ViewModel/AppPageViewModel/HomePageViewModel.dart';
import 'package:delivaryhalaapp/provider/ActiveState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../ thems/colors.dart';
import '../../widget/MapModel.dart';
import '../../../provider/DataUser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
var themeApp=myAppTheme();

class _HomePageState extends State<HomePage> {

var homePageVM=HomePageVM();

 @override
  void initState() {
    homePageVM.getDataFromDB(context);
    homePageVM.initalMessage(context);
    homePageVM.messagingOnOpenApp(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    themeApp.getSizePhone(context);
    final DataUser = Provider.of<Userdata>(context).getUser;
    return homePageVM.downloadData? Scaffold(
      key: homePageVM.ScaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyCustomWidget(),
              SizedBox(height:themeApp.H/10,),
              Container(
                margin: EdgeInsets.only(left: themeApp.W/15,right: themeApp.W/15),
                child: Bottom(function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => accountPage(),));
                }, textcolor: Colors.white, color1:themeApp.color1, color2: themeApp.color2, text: 'حسابي',fontSize: themeApp.W/20,w: themeApp.W,h:themeApp.H/15),
              ),
              SizedBox(height:themeApp.H/20,),
              Container(
                margin: EdgeInsets.only(left: themeApp.W/15,right: themeApp.W/15),
                child: Bottom(function: (){
                  FireBaseStatment().signOut(context: context);
                }, textcolor: Colors.white,  color1:themeApp.color1, color2: themeApp.color2, text: 'تسجيل الخروج',fontSize: themeApp.W/20,w: themeApp.W,h:themeApp.H/15),
              ),
            ],
          ),
        ),
        width: themeApp.W/2,
        backgroundColor: Colors.white70,
      ),
      body: Stack(
        children: [
          Container(
            height: themeApp.H,
            width: themeApp.W,
            child: MapLocation(whichPage:true,OrdarData: {}),
          ),
          Positioned(
              bottom:themeApp.H/19,
              child:Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('DilevaryHala').where('Uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    return Container(
                      width: themeApp.W,
                      child: Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Talabat(),));
                          },
                          child: Container(
                            decoration: themeApp.decrotion1,
                            width: themeApp.W*0.4,
                            padding: EdgeInsets.only(top:themeApp.H/500,bottom:themeApp.H/500),
                            child: Center(child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('الطلبات',style: TextStyle(fontSize: themeApp.W/13,color: Colors.white,fontWeight: FontWeight.bold),),
                                Container(
                                  padding: EdgeInsets.all(themeApp.H/80),
                                  decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                                  child: Text(snapshot.data!.docs[0]['Ordar'].length.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: themeApp.W/13),),)
                              ],
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
          ),
          Positioned(
            top:themeApp.H/18,
            left: themeApp.W/35,
            child: InkWell(
              onTap: () {
                homePageVM.ScaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                height:themeApp.H/15,
                width:themeApp.H/15,
                decoration: themeApp.decrotion1,
                child: Center(
                  child: Icon(Icons.settings_outlined,color: Colors.white,size:themeApp.H/23,),
                ),
              ),
            ),
          )
        ],
      ),
    )
        :
    Container(height:  themeApp.H,width:  themeApp.W,color: Colors.white,child: Center(child: CircularProgressIndicator(),),)
    ;
  }
}

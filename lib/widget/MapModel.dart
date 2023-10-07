import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivaryhalaapp/widget/Botton.dart';
import 'package:delivaryhalaapp/widget/SnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../View/AppPage/homePage.dart';
import '../Services/YourBackgroundService.dart';
import '../models/Navigation.dart';
import '../provider/DataUser.dart';
import 'SwipButton.dart';


class MapLocation extends StatefulWidget {
  Map OrdarData;
  bool whichPage;
  //true=HomePage//false=OrdarPage;
  MapLocation({required this.OrdarData,required this.whichPage,Key? key}) : super(key: key);

  @override
  State<MapLocation> createState() => _MapLocationState();
}


int value=9;
class _MapLocationState extends State<MapLocation> {
  LatLng? _myLocation;
  LatLng? _NewLocation;
  late StreamSubscription<Position> positionStreamSubscription;
  LatLng _startPoint=LatLng(0.0, 0.0);
  bool locationGet=false;
  List<LatLng> MarketPoint = [];
  List<LatLng> UserPoint = [];
  double distance = 0.0;
  List<Marker> _markers = [];
  Position? _currentPosition;
  MapController mapController=MapController();
  bool ordarGet=false;
  String TextName='';
  Distance distanceRefrish = Distance();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  messagingOnOpenApp(BuildContext context){
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if(event.notification!.title=='تحديث الموقع'){
   /*     EditLocation();
        print('تم تحديث الموقع ');*/
      }
    });
  }



  getDataFromDB() async {
    Userdata userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }




  Future<Position> detrmineLocation() async{
    LocationPermission premission;
    premission = await Geolocator.checkPermission();
    if(premission == LocationPermission.denied){
      premission = await Geolocator.requestPermission();
      if(premission == LocationPermission.denied){
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getMyLocation() async {
    if (mounted) { // فحص حالة المكون قبل استدعاء setState
      Position myLocation = await detrmineLocation();
      setState(() {
        _myLocation = LatLng(myLocation.latitude, myLocation.longitude);
        _myLocation == null ? locationGet = false : locationGet = true;
      });
    }
  }





  Future<void> getRoute() async {
    if (_myLocation != null && _startPoint != null) {
      final String apiUrl =
          'https://router.project-osrm.org/route/v1/driving/${_myLocation!.longitude},${_myLocation!.latitude};${_startPoint.longitude},${_startPoint.latitude}?geometries=geojson';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];
        MarketPoint = coordinates
            .map((coordinate) => LatLng(coordinate[1], coordinate[0]))
            .toList();

        // حساب المسافة بين النقطتين
        double distanceInMeters = data['routes'][0]['distance']*1.0;
        distance = distanceInMeters ; // تحويل المسافة إلى كيلومترات
        setState(() {
          if(distance<1000000){ordarGet=true;}
          else{ordarGet=false;}
        });
      }
    }
  }



haveOrdar(){
  GeoPoint user=widget.OrdarData['UserLocation'];
  setState(() {
    _startPoint=LatLng(user.latitude, user.longitude);
    TextName=widget.OrdarData['Name'];
    widget.OrdarData['State']=1;
  });
  }

  @override
  void initState() {

    /**/
/*    Stream<int?> DelivaryState() {
      try {
        return FirebaseFirestore.instance
            .collection('UpdateLocation')
            .doc('City1')
            .snapshots()
            .map<int?>((snapshot) {
          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            final numValue = data['Update'] as int?;
            return numValue;
          } else {
            return null; // إذا لم يتم العثور على المستند
          }
        });
      } catch (e) {
        print(e);
        return Stream.empty(); // في حالة حدوث خطأ
      }
    }
    *//**//*
    final numStream = DelivaryState();

    numStream.listen((numValue) {
      if (numValue != null && numValue == 1 ) {


        print('Value of Num: $value');
        getMyLocation();
        print(_myLocation);
*//*
        EditLocation();
*//*

        // هنا يمكنك القيام بما تريده باستخدام القيمة المُراقبة
      } else {
        Timer.periodic(Duration(seconds: 1), (timer) {    value=numValue as int;});
        print('Document not found');
      }
    });*/


    getMyLocation();
    if(widget.whichPage==false){
     GeoPoint market=widget.OrdarData['MarketLocation'];
     _startPoint=LatLng(market.latitude, market.longitude);
     TextName=widget.OrdarData['MarketName'];
    }
    widget.whichPage? null:getRoute();
    messagingOnOpenApp(context);

    positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
      LatLng newLocation = LatLng(position.latitude, position.longitude);
      setState(() {
        _myLocation = newLocation;
      });
      getRoute();
    });



    super.initState();
  }

  void dispose() {
    positionStreamSubscription.cancel(); // إلغاء اشتراك التحديثات المستمرة للموقع
    super.dispose();
  }







/*latitude:32.323002, longitude:35.368901*/
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return locationGet? Stack(
      children: [
        Container(
          width: w,
          height: h,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: _myLocation!,
              minZoom: 10,
              maxZoom: 18,
              zoom: 16,
            ),
            nonRotatedChildren: [

              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              widget.whichPage?Container():MarkerLayer(
                markers: [
                  Marker(point: _startPoint, builder:(context)=>Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ))
                ],
              ),

              MarkerLayer(
                markers: [
                  Marker(
                    point: _myLocation!,
                    builder: (BuildContext context) {
                      return Container(
                        child: Icon(Icons.location_history,color: Colors.red,size: 25,),
                      );
                    },
                  ),
                ],
              ),
              widget.whichPage? Container():PolylineLayer(
                polylines: [
                  Polyline(
                    points: MarketPoint,
                    color: Colors.teal, // لون المسار
                    strokeWidth: 5,   // عرض المسار
                  ),
                ],
              ),
            ],
          ),

        ),
        widget.whichPage?Container()
            :
        Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(topRight:Radius.circular(30) ,topLeft: Radius.circular(30))
              ),
              width: w,
              height: h/4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: w/4,right: w/4,top: h/100,bottom: h/100),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.purpleAccent,width: 2)),
                    child: Center(child: Text(TextName,maxLines:1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/17),)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: w/4,right: w/4,top: h/100,bottom: h/100),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.purpleAccent,width: 2,)),
                    child: Center(child: Text('متر '+(distance).toString(),maxLines:1,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/18),)),
                  ),
                  ordarGet?
                  widget.OrdarData['State']==0?
                  SwipButton(
                    height: h/13,
                    borderRadius: w/10,
                    iconSize: w/18,
                    text: 'التالي',
                    width: 400,
                    dragableIconBackgroundColor: Colors.greenAccent,
                    textStyle: TextStyle(color: Colors.white,fontSize: 15),
                    backgroundColor:Colors.green,
                    onSubmit:() {
                        String TextShow='';
                        setState(() {
                          TextShow='هل استلمت الطلب من المطعم؟';
                        });
                        showDialog(context: context, builder: (context) => Center(
                          child: Container(
                            height: h/4,
                            width: w*0.8,
                            decoration:BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,) ,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(TextShow,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: w/18)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(onPressed: () async {
                                      haveOrdar();
                                      Navigator.pop(context);
                                    }, child: Text('نعم',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),)
                                      ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                    ElevatedButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text('لا',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),)
                                      ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        );
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

                      :
                  SwipButton(
                    height: h/13,
                    borderRadius: w/10,
                    iconSize: w/18,
                    text: 'التالي',
                    width: 400,
                    dragableIconBackgroundColor: Colors.greenAccent,
                    textStyle: TextStyle(color: Colors.white,fontSize: 15),
                    backgroundColor:Colors.green,
                    onSubmit: () {
                      String TextShow='';
                      setState(() {
                        TextShow='هل تم تسليم الطلب؟';
                      });
                      showDialog(context: context, builder: (context) => Center(
                        child: Container(
                          height: h/4,
                          width: w*0.8,
                          decoration:BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,) ,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(TextShow,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: w/18)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(onPressed: () async {
                                    double Profit;
                                    double OrdarDelivary=widget.OrdarData['PriseDelivary']*1.0;
                                    await getDataFromDB();
                                    Profit=(DataUser!.Prifit+OrdarDelivary)*1.0;
                                    widget.OrdarData['State']=2;
                                    widget.OrdarData['Time']=DateTime.now();

                                    for(int i=DataUser!.Ordar.length-1;i>=0;i--){
                                      if(widget.OrdarData['orderID']==DataUser!.Ordar[i]['orderID']){
                                        DataUser!.Ordar.removeAt(i);
                                        break;
                                      }
                                      else{null;}

                                    }
                                    try{
                                      DataUser!.OrdarDone.add(widget.OrdarData);
                                      await FirebaseFirestore.instance.collection('DilevaryHala').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                          {'OrdarDone': DataUser!.OrdarDone,
                                            'Ordar':DataUser!.Ordar,
                                            'Prifit':Profit,
                                          });
                                      getDataFromDB();
                                      Navigator.pop(context);
                                      Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                                      showSnackBar(context: context, text: 'تم إضافة الطلب الى المحفظة', color1: Colors.black38);
                                    }catch(e){showSnackBar(context: context, text: "تم اضافة الطلب الى الاحصائيات", color1: Colors.greenAccent);}
                                  }, child: Text('نعم',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),)
                                    ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                  ElevatedButton(onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text('لا',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),)
                                    ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      );
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
                      :
                  Container(),
                ],
              ),
            )),

        widget.whichPage?Container()
            :
        Positioned(
          bottom: h/5,
          right: w/25,
         child: FloatingActionButton(
           backgroundColor: Colors.blueAccent,
           onPressed: () {
           getRoute();
           mapController.move(_myLocation!, 18.0);
         },child: Icon(Icons.my_location_outlined,color: Colors.white,),),
       ),
        widget.whichPage?Container()
            :
        Positioned(
          bottom: h/5,
          left: w/25,
          child: FloatingActionButton(onPressed: () {
            showDialog(context: context, builder: (context) =>
              Center(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,),
                  height: h/3.5,
                  width: w*0.8,
                  padding: EdgeInsets.only(top: h/50,bottom: h/50,right: w/35,left: w/35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'بإمكانك الحصول على المسار عبر التطبيقات التالية',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: w/18),
                              )
                            ]
                          ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              lunchGoogleMap().openGoogleMaps(Location: _startPoint);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(h/50),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                              child: SvgPicture.asset('assets/Img/googleMap.svg',height: h/18,fit: BoxFit.cover,),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                             await lunchWaze(LngLocation:_startPoint.longitude ,LatLocation:_startPoint.latitude ).launchWaze(context: context);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(h/50),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                              child: SvgPicture.asset('assets/Img/Waze.svg',height: h/18,fit: BoxFit.cover,),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            );
          },child: Icon(Icons.navigation,size: w/15,),backgroundColor: Colors.purple.shade400),
        ),
        Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('UpdateLocation').where('city',isEqualTo: DataUser!.City).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
/*
              snapshot.data!.docs[0]['Update']==0?null:EditLocation();
*/
              return Container();
            },
          ),
        ),
      ],
    )
        :
    Container(height: h,width: w,color: Colors.white,child: Center(child: CircularProgressIndicator(),),)
    ;
  }
}


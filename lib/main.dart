import 'package:delivaryhalaapp/provider/ActiveState.dart';
import 'package:delivaryhalaapp/provider/DataUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'View/authPages/LogInPage.dart';
import 'widget/SnackBar.dart';
import 'View/AppPage/homePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) {return Userdata();},),
      ChangeNotifierProvider(create: (context) {return activeState();},)
    ],
    child:  MaterialApp(
      home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: CircularProgressIndicator(color: Colors.white,));}
        else if (snapshot.hasError) {return showSnackBar(context: context, text: 'Error 404', color1: Colors.red);}
        else if (snapshot.hasData) {return const HomePage();}
        else { return const LogInPage();}
      },
    ),        debugShowCheckedModeBanner: false,),
    );
  }
}

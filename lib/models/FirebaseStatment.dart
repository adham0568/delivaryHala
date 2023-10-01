
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../View/authPages/LogInPage.dart';
import '../View/AppPage/homePage.dart';
import 'userData.dart';
import '../widget/SnackBar.dart';

class FireBaseStatment{
  SingUp(
      {required BuildContext context,
      required String EmailAddress,
      required String Name,
      required String Password,
      required String Phone,
      required int City,
      required String token,
      }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:EmailAddress,
        password: Password,
      );

      UserData _UserData=UserData(
          EmailAddress: EmailAddress,
          Name: Name,
          Password: Password,
          Uid: credential.user!.uid,
          Ordar: [],
          OrdarDone: [],
          Location: GeoPoint(32.321478, 35.370473),
          City: City,
          Prifit: 0,
          PhoneNumber: Phone,
          active: 0,
          feildOrdar: 0,
          token: token,
      );
      FirebaseFirestore.instance.collection('DilevaryHala').doc(credential.user!.uid).set(_UserData.Convert2Map());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInPage()));

      showSnackBar(context: context, text: 'Account Created', color1: Colors.green);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  LogIn({required String Email,required String Password,required BuildContext context}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email,
          password: Password
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<UserData> GetUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('DilevaryHala').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserData.convertSnap2Model(snap);
  }


  void signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage(),));
      // قم بتنفيذ أي إجراءات إضافية بعد تسجيل الخروج إذا كنت بحاجة إليها
    } catch (e) {
      print("Error signing out: $e");
    }
  }


}
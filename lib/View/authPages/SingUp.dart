import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ViewModel/authPageViewModel/singUpPageViewModel.dart';
import '../../models/FirebaseStatment.dart';
import 'LogInPage.dart';


class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  var dataViewModel=singUpViewModel();
  @override
  void initState() {
    dataViewModel.getToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    dataViewModel.getSizeSecreen(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left:dataViewModel.W/10,right: dataViewModel.W/10,top: dataViewModel.H/5),
              height: dataViewModel.H/1.5,
              child: Column(
                children: [
                  TextFormField(
                    controller: dataViewModel.Name,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black12),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: Colors.teal,
                      fillColor: Colors.black12,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: dataViewModel.H/30,),
                  TextFormField(
                    controller: dataViewModel.Email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black12),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.teal,
                      fillColor: Colors.black12,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: dataViewModel.H/30,),
                  TextFormField(
                    controller: dataViewModel.Phone,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black12),
                      hintText: 'Phone',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.phone),
                      prefixIconColor: Colors.teal,
                      fillColor: Colors.black12,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: dataViewModel.H/30,),
                  TextFormField(
                    controller: dataViewModel.Password,
                    obscureText:dataViewModel.showPssword,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black12),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.password),
                      prefixIconColor: Colors.teal,
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          dataViewModel.showPssword =! dataViewModel.showPssword;
                        });
                      },icon: Icon(Icons.remove_red_eye,color: Colors.teal,)),
                      fillColor: Colors.black12,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: dataViewModel.H/28,),
                  InkWell(
                    onTap:() async {
                     await FireBaseStatment().SingUp(token: dataViewModel.token,context: context, EmailAddress: dataViewModel.Email.text, Password: dataViewModel.Password.text, Phone: dataViewModel.Phone.text, City: 12,Name:dataViewModel.Name.text );
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage(),));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: dataViewModel.W/15,vertical: dataViewModel.W/70),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.green,
                            CupertinoColors.systemGreen,
                          ]
                      )),
                      child: Text('إنشاء حساب',style: dataViewModel.myTextStyle,),
                    ),
                  ),
                  SizedBox(height: dataViewModel.H/25,),
                  TextButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage(),));
                  }, child: Text('تسجيل الدخول',style: TextStyle(fontWeight: FontWeight.bold,fontSize: dataViewModel.W/20,color: Colors.blueAccent),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

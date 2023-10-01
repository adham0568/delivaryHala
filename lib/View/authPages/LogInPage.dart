import 'package:delivaryhalaapp/models/FirebaseStatment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../ViewModel/authPageViewModel/logInPageViewModel.dart';
import 'SingUp.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var dataLogInModelView=logInPageViewModel();
  @override
  Widget build(BuildContext context) {
    dataLogInModelView.getSizeSecreen(context);
    return Scaffold(
     body: Container(
       child: SingleChildScrollView(
         child: Column(
           children: [
             Stack(
               children: [
                 Container(height: dataLogInModelView.H/3,
                 child: Center(
                   child: Container(
                     child: Image.asset('assets/Img/Logo.png',height: dataLogInModelView.H/6,color: Colors.teal,),
                   ),
                 ),
                 ),
                 Positioned(right: -dataLogInModelView.W/9,top: -dataLogInModelView.H/50,child: Image.asset('assets/shape/shape1.png',height: dataLogInModelView.H/3,))
               ],
             ),
             Container(
               margin: EdgeInsets.symmetric(horizontal: dataLogInModelView.W/10),
               height: dataLogInModelView.H/2.5,
             child: Column(
               children: [
                 TextFormField(
                   controller: dataLogInModelView.Email,
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
                 SizedBox(height: dataLogInModelView.H/30,),
                 TextFormField(
                   controller: dataLogInModelView.Password,
                   obscureText:dataLogInModelView.showPssword,
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
                         dataLogInModelView.showPssword != dataLogInModelView.showPssword;
                       });
                     },icon: Icon(Icons.remove_red_eye,color: Colors.teal,)),
                     fillColor: Colors.black12,
                     filled: true,
                   ),
                 ),
                 SizedBox(height: dataLogInModelView.H/28,),
                 InkWell(
                   onTap:() async {
                    await FireBaseStatment().LogIn(Email: dataLogInModelView.Email.text, Password: dataLogInModelView.Password.text,context: context);
                   },
                   borderRadius: BorderRadius.circular(15),
                   child: Container(
                     padding: EdgeInsets.symmetric(horizontal: dataLogInModelView.W/15,vertical: dataLogInModelView.W/70),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: LinearGradient(
                       begin: Alignment.topRight,
                       end: Alignment.bottomLeft,
                       colors: [
                         Colors.green,
                         CupertinoColors.systemGreen,
                       ]
                     )),
                     child: Text('تسجيل الدخول',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: dataLogInModelView.W/18),),
                   ),
                 ),
                 SizedBox(height: dataLogInModelView.H/25,),
                 TextButton(onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => SingUp(),));
                 }, child: Text('إنشاء حساب',style: TextStyle(fontWeight: FontWeight.bold,fontSize: dataLogInModelView.W/20,color: Colors.blueAccent),))
               ],
             ),
             ),
             Transform.translate(offset: Offset(-dataLogInModelView.W/3.5,-dataLogInModelView.H/10),
             child: Image.asset('assets/shape/shape2.png',height: dataLogInModelView.H/2.5,),
             )
           ],
         ),
       ),
     ),
    );
  }
}

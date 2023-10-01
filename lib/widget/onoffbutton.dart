import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivaryhalaapp/widget/SnackBar.dart';
import 'package:delivaryhalaapp/provider/ActiveState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/DataUser.dart';

class MyCustomWidget extends StatefulWidget {
@override
_MyCustomWidgetState createState() => _MyCustomWidgetState();
}




class _MyCustomWidgetState extends State<MyCustomWidget>
with TickerProviderStateMixin {
  bool isChecked = false;
Duration _duration = Duration(milliseconds: 370);
late Animation<Alignment> _animation;
late AnimationController _animationController;

@override
  void initState() {
  super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _animation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    DataUser!.active==0?isChecked=true:isChecked=false;
    final active=Provider.of<activeState>(context);
    return Column(
      children: [
        Text(isChecked?'حالة النشط':'ايقاف العمل',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: w/18),),
        Container(
          width: double.infinity,
          height: h/10,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(isChecked? Icons.flash_on:Icons.flash_off_rounded,size: w/18,color:isChecked?Colors.yellowAccent:Colors.red,),
                    Text(isChecked?'نشط':'غير نشط',style: TextStyle(fontSize: w/22,color: isChecked?Colors.green:Colors.pink,fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('الحالة',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: w/18),),
              ],
            ),
          ),
        ),
        Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Center(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    setState(
                          (){
                        if (_animationController.isCompleted) {
                          _animationController.reverse();
                        } else {
                          _animationController.forward();
                        }
                        isChecked = !isChecked;
                        if(isChecked==false){
                            FirebaseFirestore.instance.collection('DilevaryHala').doc(FirebaseAuth.instance.currentUser!.uid).update({'active':1});
                            active.active=false;
                            DataUser!.active=1;
                        }
                        else if(isChecked==true){
                            FirebaseFirestore.instance.collection('DilevaryHala').doc(FirebaseAuth.instance.currentUser!.uid).update({'active':0});
                            active.active=true;
                            DataUser!.active=0;
                        }
                      },
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                    decoration: BoxDecoration(
                      color: isChecked ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(99),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isChecked
                              ? Colors.green.withOpacity(0.6)
                              : Colors.red.withOpacity(0.6),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: _animation.value,
                          child: GestureDetector(
                            onTap: () {
                              setState(
                                    () {
                                  if (_animationController.isCompleted) {
                                    _animationController.reverse();
                                  } else {
                                    _animationController.forward();
                                  }
                                  isChecked = !isChecked;
                                },
                              );
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    )
    ;
  }
}

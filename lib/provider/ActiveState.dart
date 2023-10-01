import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class activeState with ChangeNotifier{
  late bool active=false;

@override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
import 'package:flutter/material.dart';

import '../models/FirebaseStatment.dart';
import '../models/userData.dart';


class Userdata with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;

  refreshUser() async {
    UserData userData = await FireBaseStatment().GetUserDetails();
    _userData = userData;
    notifyListeners();
  }
}

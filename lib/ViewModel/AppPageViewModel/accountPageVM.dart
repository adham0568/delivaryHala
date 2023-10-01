import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/DataUser.dart';

class accountPageVM with ChangeNotifier{


  BuildContext context;
  accountPageVM({required this.context});

  Userdata get Provideer => Provider.of<Userdata>(context);

}

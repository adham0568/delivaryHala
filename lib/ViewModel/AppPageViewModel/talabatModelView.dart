import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../provider/DataUser.dart';

class talabatModelView with ChangeNotifier{
  bool _downloadData=false;
  bool get DownloadData=>_downloadData;
  List Ordars=[];

  getDataFromDB(BuildContext context) async {
    Userdata userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    _downloadData=true;
    notifyListeners();
  }
}
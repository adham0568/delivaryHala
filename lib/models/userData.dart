import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class UserData{
  String Name,Uid,EmailAddress,Password,PhoneNumber,token;
  List Ordar,OrdarDone;
  GeoPoint Location;
  int City;
  int active,feildOrdar;
  double Prifit;


  UserData(
      {
        required this.EmailAddress,
        required this.Name,
        required this.token,
        required this.Password,
        required this.Uid,
        required this.Ordar,
        required this.OrdarDone,
        required this.Location,
        required this.City,
        required this.Prifit,
        required this.PhoneNumber,
        required this.active,
        required this.feildOrdar,
      });



  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'EmailAddress':EmailAddress,
      'Password':Password,
      'Uid':Uid,
      'Ordar':Ordar,
      'OrdarDone':OrdarDone,
      'Location':Location,
      'City':City,
      'Prifit':Prifit,
      'PhoneNumber':PhoneNumber,
      'active':active,
      'feildOrdar':feildOrdar,
      'token':token,
    };
  }

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
      EmailAddress: snapshot["EmailAddress"],
      Name: snapshot["Name"],
      Password: snapshot["Password"],
      Uid: snapshot["Uid"],
      Ordar: snapshot["Ordar"],
      OrdarDone: snapshot["OrdarDone"],
      Location: snapshot['Location'],
      City: snapshot['City'],
      Prifit:snapshot['Prifit']*1.0,
      PhoneNumber:snapshot['PhoneNumber'],
      active:snapshot['active'],
      feildOrdar:snapshot['feildOrdar'],
      token:snapshot['token'],
    );
  }

}
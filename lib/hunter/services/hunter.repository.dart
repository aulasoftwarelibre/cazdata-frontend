import 'package:cazdata_frontend/hunter/model/hunter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HunterRepository {
  Future<bool> postHunter(Hunter hunter, String idToken) async {
    Firestore.instance
        .collection('hunters')
        .document()
        .setData({
          'hunterId': hunter.id,
          'email': hunter.email,
          'displayName': hunter.displayName,
          'photoUrl': hunter.photoUrl,
          'isEmailVerified': hunter.isEmailVerified
        })
        .then((value) => null)
        .catchError(() => null);

    return false;
  }
}

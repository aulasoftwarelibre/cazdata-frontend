import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HunterRepository {
  Future<bool> createHunter(Hunter hunter) async {
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

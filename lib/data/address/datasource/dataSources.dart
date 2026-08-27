import 'package:cloud_firestore/cloud_firestore.dart';

class Datasources {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveAdd({
    required String userId,
    required String name,
    required String phone,
    required String address1,
    required String address2,
    required String city,
    required String pincode,
    required String state,
  }) async {
    final docId = '${userId}_$name';
    await _firestore.collection('add').doc(docId).set({
      'userId': userId,
      'name': name,
      'phone': phone,
      'address1': address1,
      'address2': address2,
      'city': city,
      'pincode': pincode,
      'state': state,
    });
  }

  Stream<QuerySnapshot> getAdd({required String userId}) {
    final body = _firestore
        .collection('add')
        .where('userId', isEqualTo: userId)
        .snapshots();
    return body;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CartDataSources {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addToCart({
    required String userId,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
  }) async {
    final docId = '${userId}_$productId';
    final docRef = firestore.collection('cart').doc(docId);
    final existingDoc = await docRef.get();
    if (existingDoc.exists) {
      await docRef.update({'quantity': FieldValue.increment(1)});
    } else {
      await docRef.set({
        'productId': productId,
        'userId': userId,
        'quantity': 1,
        'title': title,
        'price': price,
        'thumbnail': thumbnail,
      });
    }
  }

  Future<void> removeFromCart({
    required String userId,
    required int productId,
  }) async {
    final docId = '${userId}_$productId';
    final docRef = firestore.collection('cart').doc(docId);
    await docRef.delete();
  }

  Stream<QuerySnapshot> getCart({required String userId}) {
    final body = firestore
        .collection('cart')
        .where('userId', isEqualTo: userId)
        .snapshots();
    return body;
  }
}

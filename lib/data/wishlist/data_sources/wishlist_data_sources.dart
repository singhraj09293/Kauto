import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistDataSources {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addToWhishList({
    required String userId,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
  }) async {
    final docId = '${userId}_$productId';
    final docRef = _firestore.collection('wishlist').doc(docId);
    await docRef.set({
      'productId': productId,
      'userId': userId,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
    });
  }

  Future<void> removeWhishList({
    required String userId,
    required int productId,
  }) async {
    final docId = '${userId}_$productId';
    final docRef = _firestore.collection('wishlist').doc(docId);
    await docRef.delete();
  }

  Stream<QuerySnapshot> getWishList({required String userId}) {
    final body = _firestore
        .collection('wishlist')
        .where('userId', isEqualTo: userId)
        .snapshots();
    return body;
  }
}

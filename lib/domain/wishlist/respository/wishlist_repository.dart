import 'package:kauto/domain/wishlist/wishlist_item.dart';

abstract class WishlistRepository {
  Stream<List<WishlistItem>> getWishList({required String userId});
  Future<void> addToWhishList({
    required String userId,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
  });
  Future<void> removeWhishList({
    required String userId,
    required int productId,
  });
}

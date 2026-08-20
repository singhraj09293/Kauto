import 'package:kauto/domain/cart/cart_item.dart';

abstract class CartRepository {
  Stream<List<CartItem>> getCart({required String userId});
  Future<void> addToCart({
    required String userId,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
    required String desc,
  });
  Future<void> removeFromCart({required String userId, required int productId});
}

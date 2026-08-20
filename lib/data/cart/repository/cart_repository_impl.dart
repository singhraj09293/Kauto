import 'package:kauto/data/cart/data_sources/cart_data_sources.dart';
import 'package:kauto/domain/cart/cart_item.dart';
import 'package:kauto/domain/cart/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSources dataSources;

  CartRepositoryImpl({required this.dataSources});

  @override
  Future<void> addToCart({
    required String userId,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
    required String desc,
  }) async {
    return await dataSources.addToCart(
      userId: userId,
      productId: productId,
      title: title,
      price: price,
      thumbnail: thumbnail,
      desc: desc,
    );
  }

  @override
  Stream<List<CartItem>> getCart({required String userId}) {
    return dataSources.getCart(userId: userId).map((snapshot) {
      return snapshot.docs
          .map((doc) => CartItem.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<void> removeFromCart({
    required String userId,
    required int productId,
  }) async {
    return await dataSources.removeFromCart(
      userId: userId,
      productId: productId,
    );
  }
}

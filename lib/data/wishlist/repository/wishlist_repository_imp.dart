import 'package:kauto/data/wishlist/data_sources/wishlist_data_sources.dart';
import 'package:kauto/domain/wishlist/respository/wishlist_repository.dart';
import 'package:kauto/domain/wishlist/wishlist_item.dart';

class WishlistRepositoryImp implements WishlistRepository {
  final WishlistDataSources dataSources;

  WishlistRepositoryImp({required this.dataSources});
  @override
  Future<void> addToWhishList({
    required String userId,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
  }) {
    return dataSources.addToWhishList(
      userId: userId,
      productId: productId,
      title: title,
      price: price,
      thumbnail: thumbnail,
    );
  }

  @override
  Stream<List<WishlistItem>> getWishList({required String userId}) {
    return dataSources.getWishList(userId: userId).map((snapshot) {
      return snapshot.docs
          .map(
            (docs) => WishlistItem.fromMap(docs.data() as Map<String, dynamic>),
          )
          .toList();
    });
  }

  @override
  Future<void> removeWhishList({
    required String userId,
    required int productId,
  }) {
    return dataSources.removeWhishList(userId: userId, productId: productId);
  }
}

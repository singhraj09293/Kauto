import 'package:kauto/data/wishlist/data_sources/wishlist_data_sources.dart';
import 'package:kauto/data/wishlist/repository/wishlist_repository_imp.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';
import 'package:riverpod/riverpod.dart';

final wishlistRepositoryProvider = Provider(
  (ref) => WishlistRepositoryImp(dataSources: WishlistDataSources()),
);
final wishlistProvider = StreamProvider((ref) {
  final repository = ref.watch(wishlistRepositoryProvider);
  final user = ref.watch(userProvider);
  return repository.getWishList(userId: user);
});

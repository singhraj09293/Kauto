import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/data/cart/data_sources/cart_data_sources.dart';
import 'package:kauto/data/cart/repository/cart_repository_impl.dart';
import 'package:kauto/domain/cart/cart_item.dart';

final userProvider = Provider<String>(
  (ref) => FirebaseAuth.instance.currentUser!.uid,
);
final cartRepositoryProvider = Provider(
  (ref) => CartRepositoryImpl(dataSources: CartDataSources()),
);
final cartProvider = StreamProvider<List<CartItem>>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  final user = ref.watch(userProvider);
  return repository.getCart(userId: user);
});

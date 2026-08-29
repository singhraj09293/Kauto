import 'package:kauto/data/address/datasource/dataSources.dart';
import 'package:kauto/data/address/repository/add_repository_imp.dart';
import 'package:kauto/domain/address/address.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';
import 'package:riverpod/riverpod.dart';

final addRepositoryProvider = Provider(
  (ref) => AddRepositoryImp(addDataSource: Datasources()),
);
final addProvider = StreamProvider<List<Address>>((ref) {
  final repository = ref.watch(addRepositoryProvider);
  final user = ref.watch(userProvider);
  return repository.getAdd(userId: user);
});

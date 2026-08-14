import 'package:kauto/data/product/data_sources/product_remote_datasource.dart';
import 'package:kauto/data/product/repository/product_repository_imp.dart';
import 'package:kauto/domain/product/product.dart';
import 'package:riverpod/riverpod.dart';

final productRespositoryProvider = Provider(
  (ref) => ProductRepositoryImp(ProductRemoteDatasource()),
);
final productProvider = FutureProvider<List<Product>>((ref) {
  final repository = ref.watch(productRespositoryProvider);
  return repository.getProducts();
});

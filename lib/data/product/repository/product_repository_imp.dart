import 'package:kauto/data/product/data_sources/product_remote_datasource.dart';
import 'package:kauto/domain/product/product.dart';
import 'package:kauto/domain/product/repository/product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductRemoteDatasource datasource;
  ProductRepositoryImp(this.datasource);

  @override
  Future<List<Product>> getProducts() async {
    return await datasource.fetchProducts();
  }
}

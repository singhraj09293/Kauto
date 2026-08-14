import 'package:kauto/domain/product/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

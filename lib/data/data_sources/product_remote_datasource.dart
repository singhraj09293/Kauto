import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kauto/data/model/product_model.dart';

class ProductRemoteDatasource {
  Future<List<ProductModel>> fetchProducts() async {
    final url = "https://dummyjson.com/products";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> productJson = data['products'];
        return productJson.map((p) => ProductModel.fromJson(p)).toList();
      } else {
        throw Exception(
          'Server error: Failed to load user (${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Server error: Failed to load user ($e)');
    }
  }
}

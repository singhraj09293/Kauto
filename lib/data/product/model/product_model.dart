import 'package:kauto/domain/product/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.rating,
    required super.stock,
     super.brand,
    required super.images,
    required super.thumbnail,
  });
  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? rating,
    int? stock,
    String? brand,
    List<String>? images,
    String? thumbnail,
  }) => ProductModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    price: price ?? this.price,
    rating: rating ?? this.rating,
    stock: stock ?? this.stock,
    brand: brand ?? this.brand,
    images: images ?? this.images,
    thumbnail: thumbnail ?? this.thumbnail,
  );
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    category: json["category"],
    price: (json["price"] as num).toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    brand: json["brand"] as String?,
    images: List<String>.from(json["images"].map((x) => x)),
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "price": price,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "images": List<dynamic>.from(images.map((x) => x)),
    "thumbnail": thumbnail,
  };
}

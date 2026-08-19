import 'dart:convert';

class WishlistItem {
  final int productId;
  final String title;
  final double price;
  final String thumbnail;

  WishlistItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  WishlistItem copyWith({
    int? productId,
    String? title,
    double? price,
    String? thumbnail,
  }) {
    return WishlistItem(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      productId: map['productId'] as int,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItem.fromJson(String source) =>
      WishlistItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(productId: $productId, title: $title, price: $price, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(covariant WishlistItem other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.title == title &&
        other.price == price &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        title.hashCode ^
        price.hashCode ^
        thumbnail.hashCode;
  }
}

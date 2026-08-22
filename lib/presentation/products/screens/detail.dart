import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/domain/product/product.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';

class Detail extends ConsumerStatefulWidget {
  final Product product;
  const Detail({super.key, required this.product});

  @override
  ConsumerState<Detail> createState() => _DetailState();
}

class _DetailState extends ConsumerState<Detail> {
  @override
  Widget build(BuildContext context) {
    final isInStock = widget.product.stock > 0;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          widget.product.title,
          style: TextStyle(color: AppTheme.primary, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline_outlined),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Image.network(
                widget.product.images[0],
                fit: BoxFit.fill,
                height: 300,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.brand.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 2,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isInStock
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isInStock
                                  ? Icons.check_circle_outline
                                  : Icons.remove_circle_outline,
                              color: isInStock ? Colors.green : Colors.red,
                            ),
                            SizedBox(width: 5),
                            Text(
                              isInStock ? 'In Stock' : 'Out-of Stock',
                              style: TextStyle(
                                color: isInStock ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.product.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ...List.generate(5, (i) {
                            if (i < widget.product.rating.floor()) {
                              return Icon(Icons.star, color: Colors.amber);
                            }
                            if (i == widget.product.rating.floor() &&
                                widget.product.rating >= 0.5) {
                              return Icon(Icons.star_half, color: Colors.amber);
                            } else {
                              return Icon(
                                Icons.star_outline,
                                color: Colors.amber,
                              );
                            }
                          }),
                          SizedBox(width: 5),
                          Text(
                            '(${widget.product.rating})',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      itemCount: widget.product.images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                            widget.product.images[index],
                            height: 80,
                            width: 80,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Product Description',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.product.description,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      fixedSize: Size(360, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(cartRepositoryProvider)
                          .addToCart(
                            userId: ref.read(userProvider),
                            productId: widget.product.id,
                            title: widget.product.title,
                            price: widget.product.price,
                            thumbnail: widget.product.thumbnail,
                            desc: widget.product.description,
                          );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';
import 'package:kauto/presentation/products/providers/product_provider.dart';
import 'package:kauto/presentation/products/providers/wishlist_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final wishAsync = ref.watch(wishlistProvider);
    final wishedProduct = wishAsync.maybeWhen(
      data: (wisheItems) => wisheItems.map((e) => e.productId).toSet(),
      orElse: () => <int>{},
    );
    final cartAsync = ref.watch(cartProvider);
    final addedProductIds = cartAsync.maybeWhen(
      data: (cartItems) => cartItems.map((e) => e.productId).toSet(),
      orElse: () => <int>{},
    );
    final productAsync = ref.watch(productProvider);
    return productAsync.when(
      data: (product) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'KAUTO',
              style: TextStyle(
                color: AppTheme.primary,
                letterSpacing: 0.7,
                fontSize: 23,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_outlined),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'Search products..',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Category',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.devices,
                              color: AppTheme.primary,
                              size: 35,
                            ),
                          ),
                          Text(
                            'Electronics',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.checkroom,
                              color: AppTheme.primary,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Fashion',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chair,
                              color: AppTheme.primary,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.face_retouching_natural,
                              color: AppTheme.primary,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Beauty',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.local_grocery_store,
                              color: AppTheme.primary,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Grocery',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Trending now',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    itemCount: product.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.59,
                    ),
                    itemBuilder: ((context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1.3,
                                      child: Image.network(
                                        product[index].thumbnail,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          final isWished = wishedProduct
                                              .contains(product[index].id);
                                          if (isWished) {
                                            ref
                                                .read(
                                                  wishlistRepositoryProvider,
                                                )
                                                .removeWhishList(
                                                  userId: ref.read(
                                                    userProvider,
                                                  ),
                                                  productId: product[index].id,
                                                );
                                            setState(
                                              () => wishedProduct.remove(
                                                product[index].id,
                                              ),
                                            );
                                          } else {
                                            ref
                                                .read(
                                                  wishlistRepositoryProvider,
                                                )
                                                .addToWhishList(
                                                  userId: ref.read(
                                                    userProvider,
                                                  ),
                                                  productId: product[index].id,
                                                  title: product[index].title,
                                                  price: product[index].price,
                                                  thumbnail:
                                                      product[index].thumbnail,
                                                );
                                            setState(() {
                                              wishedProduct.add(
                                                product[index].id,
                                              );
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          wishedProduct.contains(
                                                product[index].id,
                                              )
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color:
                                              wishedProduct.contains(
                                                product[index].id,
                                              )
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              product[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  product[index].rating.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$ ${product[index].price}',
                                  style: TextStyle(
                                    color: AppTheme.primary,
                                    fontSize: 18,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    final isCarted = addedProductIds.contains(
                                      product[index].id,
                                    );
                                    if (isCarted) {
                                      ref
                                          .read(cartRepositoryProvider)
                                          .removeFromCart(
                                            userId: ref.read(userProvider),
                                            productId: product[index].id,
                                          );
                                      setState(() {
                                        addedProductIds.remove(
                                          product[index].id,
                                        );
                                      });
                                    } else {
                                      ref
                                          .read(cartRepositoryProvider)
                                          .addToCart(
                                            userId: ref.read(userProvider),
                                            productId: product[index].id,
                                            title: product[index].title,
                                            price: product[index].price,
                                            thumbnail: product[index].thumbnail,
                                          );
                                      setState(() {
                                        addedProductIds.add(product[index].id);
                                      });
                                    }
                                  },
                                  icon: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.secondary,
                                    ),
                                    child: Icon(
                                      addedProductIds.contains(
                                            product[index].id,
                                          )
                                          ? Icons.check
                                          : Icons.add,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (e, st) => Center(child: Text('Error $e')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

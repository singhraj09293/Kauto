import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';
import 'package:kauto/presentation/products/providers/product_provider.dart';
import 'package:kauto/presentation/products/providers/recent_search_provider.dart';
import 'package:kauto/presentation/products/providers/wishlist_provider.dart';
import 'package:kauto/presentation/products/screens/detail.dart';
import 'package:kauto/presentation/products/screens/search.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  String selectedCategory = '';
  late final TextEditingController searchProduct;
  @override
  void initState() {
    super.initState();
    searchProduct = TextEditingController();
    searchProduct.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchProduct.dispose();
    super.dispose();
  }

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
        final filtered = selectedCategory.isEmpty
            ? product
            : product
                  .where((p) => p.category.toLowerCase() == selectedCategory)
                  .toList();
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
                  controller: searchProduct,
                  onSubmitted: (value) async {
                    await ref
                        .read(recentSearchProvider.notifier)
                        .addSearch(searchProduct.text.trim());
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    hintText: 'Search products..',
                    hintStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade500
                          : Colors.grey.shade600,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                searchProduct.text.trim().isNotEmpty
                    ? Expanded(
                        child: SearchResult(query: searchProduct.text.trim()),
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onDoubleTap: () {
                                      setState(() {
                                        selectedCategory = '';
                                      });
                                    },
                                    onTap: () => setState(() {
                                      selectedCategory = 'fragrances';
                                    }),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.spa,
                                            color: AppTheme.primary,
                                            size: 30,
                                          ),
                                        ),
                                        Text(
                                          'Fragrances',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  GestureDetector(
                                    onDoubleTap: () {
                                      setState(() {
                                        selectedCategory = '';
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = 'furniture';
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.chair,
                                            color: AppTheme.primary,
                                            size: 30,
                                          ),
                                        ),
                                        Text(
                                          'Furniture',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  GestureDetector(
                                    onDoubleTap: () {
                                      setState(() {
                                        selectedCategory = '';
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = 'beauty';
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
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
                                  ),
                                  SizedBox(width: 30),
                                  GestureDetector(
                                    onDoubleTap: () {
                                      setState(() {
                                        selectedCategory = '';
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = 'groceries';
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
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
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              selectedCategory.isEmpty
                                  ? 'Trending now'
                                  : selectedCategory,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: GridView.builder(
                                itemCount: filtered.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                      childAspectRatio: 0.62,
                                    ),
                                itemBuilder: ((context, index) {
                                  final products = filtered[index];
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            Detail(product: filtered[index]),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 130,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(
                                                        context,
                                                      ).brightness ==
                                                      Brightness.dark
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        20,
                                                      ),
                                                  child: Image.network(
                                                    products.thumbnail,
                                                    width: double.infinity,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(
                                                        context,
                                                      ).cardColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        final isWished =
                                                            wishedProduct
                                                                .contains(
                                                                  products.id,
                                                                );
                                                        if (isWished) {
                                                          ref
                                                              .read(
                                                                wishlistRepositoryProvider,
                                                              )
                                                              .removeWhishList(
                                                                userId: ref.read(
                                                                  userProvider,
                                                                ),
                                                                productId:
                                                                    products.id,
                                                              );
                                                          setState(
                                                            () => wishedProduct
                                                                .remove(
                                                                  products.id,
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
                                                                productId:
                                                                    products.id,
                                                                title: products
                                                                    .title,
                                                                price: products
                                                                    .price,
                                                                thumbnail: products
                                                                    .thumbnail,
                                                              );
                                                          setState(() {
                                                            wishedProduct.add(
                                                              products.id,
                                                            );
                                                          });
                                                        }
                                                      },
                                                      icon: Icon(
                                                        wishedProduct.contains(
                                                              products.id,
                                                            )
                                                            ? Icons.favorite
                                                            : Icons
                                                                  .favorite_outline,
                                                        color:
                                                            wishedProduct
                                                                .contains(
                                                                  products.id,
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
                                            products.title,
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
                                                products.rating.toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$ ${products.price}',
                                                style: TextStyle(
                                                  color: AppTheme.primary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                onPressed: () {
                                                  final isCarted =
                                                      addedProductIds.contains(
                                                        products.id,
                                                      );
                                                  if (isCarted) {
                                                    ref
                                                        .read(
                                                          cartRepositoryProvider,
                                                        )
                                                        .removeFromCart(
                                                          userId: ref.read(
                                                            userProvider,
                                                          ),
                                                          productId:
                                                              products.id,
                                                        );
                                                    setState(() {
                                                      addedProductIds.remove(
                                                        products.id,
                                                      );
                                                    });
                                                  } else {
                                                    ref
                                                        .read(
                                                          cartRepositoryProvider,
                                                        )
                                                        .addToCart(
                                                          userId: ref.read(
                                                            userProvider,
                                                          ),
                                                          productId:
                                                              products.id,
                                                          title: products.title,
                                                          price: products.price,
                                                          thumbnail: products
                                                              .thumbnail,
                                                          desc: products
                                                              .description,
                                                        );
                                                    setState(() {
                                                      addedProductIds.add(
                                                        products.id,
                                                      );
                                                    });
                                                  }
                                                },
                                                icon: AnimatedContainer(
                                                  duration: Duration(
                                                    milliseconds: 100,
                                                  ),
                                                  curve: Curves.linear,
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(
                                                      context,
                                                    ).cardColor,
                                                  ),
                                                  child: Icon(
                                                    addedProductIds.contains(
                                                          products.id,
                                                        )
                                                        ? Icons.check
                                                        : Icons.add,
                                                    color:
                                                        Theme.of(
                                                              context,
                                                            ).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : AppTheme.primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
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

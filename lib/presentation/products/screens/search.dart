// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';
import 'package:kauto/presentation/products/providers/product_provider.dart';
import 'package:kauto/presentation/products/providers/recent_search_provider.dart';
import 'package:kauto/presentation/products/providers/wishlist_provider.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  TextEditingController searchProduct = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchProvider = ref.watch(recentSearchProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchProduct,
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
                  suffixIcon: Icon(Icons.cancel_outlined, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () async {
                      await ref.read(recentSearchProvider.notifier).clearAll();
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(color: AppTheme.primary, fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: searchProvider.map((search) {
                    return Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(width: 10),
                          Text(
                            search,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
              searchProduct.text.isEmpty
                  ? Trending()
                  : SearchResult(query: searchProduct.text.trim()),
            ],
          ),
        ),
      ),
    );
  }
}

class Trending extends ConsumerWidget {
  const Trending({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productRef = ref.watch(productProvider);
    return productRef.when(
      data: (product) {
        final trending = product.where((t) => t.rating > 4).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Popular products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            GridView.builder(
              itemCount: trending.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 170,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Image.network(
                            trending[index].thumbnail,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          trending[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        '\$${trending[index].price}',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
      error: (e, st) => Text('Error $e'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class SearchResult extends ConsumerStatefulWidget {
  final String query;

  const SearchResult({super.key, required this.query});

  @override
  ConsumerState<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends ConsumerState<SearchResult> {
  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productProvider);
    final wishAsync = ref.read(wishlistProvider);
    final wishedProduct = wishAsync.maybeWhen(
      data: (wisheItems) => wisheItems.map((e) => e.productId).toSet(),
      orElse: () => <int>{},
    );
    return productAsync.when(
      data: (product) {
        final result = product
            .where(
              (e) => e.title.toLowerCase().contains(widget.query.toLowerCase()),
            )
            .toList();
        return result.isNotEmpty
            ? Column(
                children: [
                  Text(
                    '${result.length} Results for "${widget.query}"',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      final pro = result[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              child: Image.network(pro.thumbnail),
                            ),
                            Column(
                              children: [
                                Text(
                                  pro.brand ?? '',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 1.5,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  pro.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber),
                                    SizedBox(width: 5),
                                    Text(
                                      pro.rating.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${pro.price}',
                                      style: TextStyle(
                                        color: AppTheme.outlinedText,
                                        fontSize: 20,
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: AppTheme.primary
                                          .withValues(alpha: 0.1),
                                      child: IconButton(
                                        onPressed: () {
                                          final isWished = wishedProduct
                                              .contains(pro.id);
                                          if (isWished) {
                                            ref
                                                .read(
                                                  wishlistRepositoryProvider,
                                                )
                                                .removeWhishList(
                                                  userId: ref.read(
                                                    userProvider,
                                                  ),
                                                  productId: pro.id,
                                                );
                                            setState(
                                              () =>
                                                  wishedProduct.remove(pro.id),
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
                                                  productId: pro.id,
                                                  title: pro.title,
                                                  price: pro.price,
                                                  thumbnail: pro.thumbnail,
                                                );
                                            setState(() {
                                              wishedProduct.add(pro.id);
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          wishedProduct.contains(pro.id)
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: wishedProduct.contains(pro.id)
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            : Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/data.png'),
                    SizedBox(height: 10),
                    Text(
                      'PRODUCT NOR FOUND!',
                      style: TextStyle(color: AppTheme.primary, fontSize: 30),
                    ),
                  ],
                ),
              );
      },
      error: (e, st) => Text('Error $e'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

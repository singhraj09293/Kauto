// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';
import 'package:kauto/presentation/products/providers/product_provider.dart';
import 'package:kauto/presentation/products/providers/recent_search_provider.dart';
import 'package:kauto/presentation/products/providers/wishlist_provider.dart';
import 'package:kauto/presentation/products/screens/detail.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
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
    final searchProvider = ref.watch(recentSearchProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  onSubmitted: (vlaue) async {
                    await ref
                        .read(recentSearchProvider.notifier)
                        .addSearch(searchProduct.text.trim());
                  },
                  controller: searchProduct,
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
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    suffixIcon: searchProduct.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchProduct.clear();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.black,
                            ),
                          )
                        : null,
                  ),
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

              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: searchProvider.map((search) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ActionChip(
                          avatar: const Icon(Icons.history, size: 18),
                          label: Text(
                            search,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            searchProduct.text = search;
                            searchProduct.selection =
                                TextSelection.fromPosition(
                                  TextPosition(offset: search.length),
                                );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Theme.of(context).cardColor,
                          elevation: 2,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              searchProduct.text.trim().isEmpty
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
            SizedBox(height: 10),
            GridView.builder(
              itemCount: trending.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                childAspectRatio: 0.57,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Detail(product: trending[index]),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: Theme.of(context).brightness == Brightness.dark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Container(
                              width: double.infinity,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade100
                                  : Colors.grey.shade50,
                              child: Image.network(
                                trending[index].thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            trending[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          '\$${trending[index].price}',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
    final wishAsync = ref.watch(wishlistProvider);
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

        if (result.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PRODUCT NOT FOUND!',
                  style: TextStyle(color: AppTheme.primary, fontSize: 20),
                ),
              ],
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${result.length} Results for "${widget.query}"',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: result.length,
              itemBuilder: (context, index) {
                final pro = result[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Detail(product: pro)),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: Theme.of(context).brightness == Brightness.dark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 130,
                          width: 110,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade100
                                : Colors.grey.shade50,
                          ),
                          child: Image.network(
                            pro.thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pro.brand ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1.5,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                pro.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
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
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '\$${pro.price}',
                                    style: TextStyle(
                                      color: AppTheme.outlinedText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  CircleAvatar(
                                    backgroundColor: AppTheme.primary
                                        .withValues(alpha: 0.1),
                                    child: IconButton(
                                      onPressed: () {
                                        final isWished = wishedProduct.contains(
                                          pro.id,
                                        );
                                        if (isWished) {
                                          ref
                                              .read(wishlistRepositoryProvider)
                                              .removeWhishList(
                                                userId: ref.read(userProvider),
                                                productId: pro.id,
                                              );
                                        } else {
                                          ref
                                              .read(wishlistRepositoryProvider)
                                              .addToWhishList(
                                                userId: ref.read(userProvider),
                                                productId: pro.id,
                                                title: pro.title,
                                                price: pro.price,
                                                thumbnail: pro.thumbnail,
                                              );
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
                        ),
                      ],
                    ),
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

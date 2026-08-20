import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';
import 'package:kauto/presentation/products/providers/wishlist_provider.dart';

class Whishlist extends ConsumerStatefulWidget {
  const Whishlist({super.key});

  @override
  ConsumerState<Whishlist> createState() => _WhishlistState();
}

class _WhishlistState extends ConsumerState<Whishlist> {
  @override
  Widget build(BuildContext context) {
    final wishAsync = ref.watch(wishlistProvider);
    return wishAsync.when(
      data: (wishlist) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'WishList',
              style: TextStyle(color: AppTheme.primary, fontSize: 25),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your WishList',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text("Items you've saved for later."),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    final wish = wishlist[index];
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
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
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                            ),
                            child: Image.network(
                              wish.thumbnail,
                              height: 80,
                              width: 80,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        maxLines: 2,
                                        wish.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        ref
                                            .read(wishlistRepositoryProvider)
                                            .removeWhishList(
                                              userId: ref.read(userProvider),
                                              productId: wish.productId,
                                            );
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 23,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$${wish.price}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
      error: (e, st) => Text('Erorr $e'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

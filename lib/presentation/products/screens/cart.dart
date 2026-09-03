import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/providers/cart_provider.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  Widget qtyControll(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  increaseQty({required int id, required int quantity}) async {
    final user = ref.read(userProvider);
    final docId = '${user}_$id';
    await FirebaseFirestore.instance.collection('cart').doc(docId).update({
      'quantity': quantity + 1,
    });
  }

  decreaseQty({required int id, required int quantity}) async {
    final user = ref.read(userProvider);
    final docId = '${user}_$id';
    if (quantity > 1) {
      await FirebaseFirestore.instance.collection('cart').doc(docId).update({
        'quantity': quantity - 1,
      });
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(docId).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider);
    return cartAsync.when(
      data: (cart) {
        double cartTotal = cart.fold(
          0,
          (sum, item) => sum + (item.price * item.quantity),
        );
        double shipping = 5.99;
        double tax = 7.99;
        double totalCart = shipping + tax + cartTotal;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart',
              style: TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final carts = cart[index];

                        return Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow:
                                Theme.of(context).brightness == Brightness.dark
                                ? [] // 👈 no shadow in dark mode
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
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child: Image.network(
                                  carts.thumbnail,
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
                                            carts.title,
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
                                                .read(cartRepositoryProvider)
                                                .removeFromCart(
                                                  userId: ref.read(
                                                    userProvider,
                                                  ),
                                                  productId: carts.productId,
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

                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${(carts.price * carts.quantity).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : AppTheme.primary,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              qtyControll(Icons.remove, () {
                                                decreaseQty(
                                                  id: carts.productId,
                                                  quantity: carts.quantity,
                                                );
                                              }),
                                              SizedBox(width: 5),
                                              Text(
                                                carts.quantity.toString(),
                                                style: TextStyle(
                                                  color:
                                                      Theme.of(
                                                            context,
                                                          ).brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : AppTheme.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              qtyControll(Icons.add, () {
                                                increaseQty(
                                                  id: carts.productId,
                                                  quantity: carts.quantity,
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow:
                            Theme.of(context).brightness == Brightness.dark
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
                          Text(
                            'Order Summary',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal', style: TextStyle(fontSize: 18)),
                              Text(
                                '\$${(cartTotal).toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping', style: TextStyle(fontSize: 18)),
                              Text(
                                '\$${(shipping).toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax', style: TextStyle(fontSize: 18)),
                              Text(
                                '\$${(tax).toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Divider(color: Colors.grey),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${(totalCart).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      fixedSize: Size(360, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 7),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (e, st) => Text('Error $e'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

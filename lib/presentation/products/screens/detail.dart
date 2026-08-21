import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/domain/product/product.dart';
import 'package:kauto/presentation/products/providers/product_provider.dart';

class Detail extends ConsumerStatefulWidget {
  final Product product;
  const Detail({super.key, required this.product});

  @override
  ConsumerState<Detail> createState() => _DetailState();
}

class _DetailState extends ConsumerState<Detail> {
  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productProvider);
    return productAsync.when(
      data: (product) {
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
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,

                ),
                child: Image.network(widget.product.images[0],fit: BoxFit.fill,height: 400,)),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                    color: Colors.white,
                    
                  ),
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

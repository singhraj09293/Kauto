import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/domain/product/product.dart';
import 'package:kauto/presentation/products/providers/product_provider.dart';

class Detail extends ConsumerStatefulWidget {
  final Product product;
  const Detail({super.key, required this.product, });

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
          appBar: AppBar(
            title: Text(
              widget.product.title,
              style: TextStyle(color: AppTheme.primary, fontSize: 25),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_outline_outlined),
              ),
            ],
          ),
          body: Column(children: [
              
            ],
          ),
        );
      },
      error: (e, st) => Text('Erorr $e'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

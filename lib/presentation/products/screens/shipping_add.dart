import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';

class ShippingAdd extends ConsumerStatefulWidget {
  const ShippingAdd({super.key});

  @override
  ConsumerState<ShippingAdd> createState() => _ShippingAddState();
}

class _ShippingAddState extends ConsumerState<ShippingAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Address',
          style: TextStyle(color: AppTheme.outlinedText),
        ),
      ),
      body: Column(children: [
        
      ],),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/presentation/auth/provider/auth_provider.dart';
import 'package:kauto/presentation/auth/sceen/login.dart';
import 'package:kauto/presentation/products/screens/home.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authWrapper = ref.watch(authProvider);
    return authWrapper.when(
      data: (user) => user != null ? Home() : Login(),
      error: (e, st) => Scaffold(body: Text('Error $e')),
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

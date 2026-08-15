import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/presentation/auth/provider/auth_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          children: [
            Text('Home'),
            IconButton(
              onPressed: () {
                try {
                  ref.read(authRepositoryProvider).signOut();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Oops ! ,$e')));
                }
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}

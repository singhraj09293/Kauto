import 'package:flutter/material.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  const ComingSoonScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Coming Soon!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
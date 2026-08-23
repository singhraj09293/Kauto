import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchProduct = TextEditingController();
   
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
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
            Divider(color: Colors.grey, thickness: 0.3, height: 2),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

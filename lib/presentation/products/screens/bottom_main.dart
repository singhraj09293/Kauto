import 'package:flutter/material.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/screens/cart.dart';
import 'package:kauto/presentation/products/screens/home.dart';
import 'package:kauto/presentation/products/screens/profile.dart';
import 'package:kauto/presentation/products/screens/search.dart';
import 'package:kauto/presentation/products/screens/whishlist.dart';

class BottomMain extends StatefulWidget {
  const BottomMain({super.key});

  @override
  State<BottomMain> createState() => _BottomMainState();
}

class _BottomMainState extends State<BottomMain> {
  int currentIndex = 0;
  List<Widget> screens = [Home(), Search(), Cart(),Whishlist(), Profile(), ];
  Widget navItem(int index, IconData icon, IconData activeIcon, String label) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppTheme.primary : Colors.grey,
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? AppTheme.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(0, Icons.home, Icons.home_filled, 'Home'),
            navItem(1, Icons.search_outlined, Icons.search, 'Search'),
            navItem(
              2,
              Icons.shopping_cart_outlined,
              Icons.shopping_cart,
              'Cart',
            ),

            navItem(
              3,
              Icons.favorite_outline, Icons.favorite,
              'WishList',
            ),
            navItem(4, Icons.person_outline, Icons.person, 'Profile'),
          ],
        ),
      ),
    );
  }
}

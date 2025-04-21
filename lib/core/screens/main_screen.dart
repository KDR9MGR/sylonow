import 'package:flutter/material.dart';
import 'package:sylonow/core/widgets/bottom_nav_bar.dart';
import 'package:sylonow/features/home/screens/home_screen.dart';
import 'package:sylonow/features/wishlist/screens/wishlist_screen.dart';
import 'package:sylonow/features/cart/screens/cart_screen.dart';
import 'package:sylonow/features/profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: TBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
} 
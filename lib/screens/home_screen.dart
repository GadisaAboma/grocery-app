import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/widgets/cart_widget.dart';
import 'package:grocery_app/widgets/category_widget.dart';
import 'package:grocery_app/widgets/favorites_widget.dart';
import 'package:grocery_app/widgets/profile_widget.dart';

import '../widgets/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget currentComponent() {
    switch (_currentIndex) {
      case 0:
        return HomeWidget(
          fun: onTabTapped,
        );
      case 1:
        return CategoryWidget();
      case 2:
        return CartWidget();
      case 3:
        return FavoritesWidget();
      case 4:
        return ProfileWidget();
      default:
        return HomeWidget(
          fun: onTabTapped,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentComponent(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

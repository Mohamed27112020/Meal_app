import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:meal_app/Views/Cart/CartScreen.dart';
import 'package:meal_app/Views/Home.dart';
import 'package:meal_app/Views/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    //  Icons.search,
    // Icons.shopping_cart_outlined,
    Icons.person,
  ];

  // Different pages for each navigation item
  final List<Widget> _pages = [
    HomeScreen(),
    //  Addmeal(),
    //  MyCartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: _pages[_bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDark ? Colors.deepOrange[900] : Colors.deepOrange,
        child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MyCartPage();
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        activeColor: isDark ? Colors.deepOrange : Colors.deepOrange,
        inactiveColor: isDark ? Colors.grey[500] : Colors.grey,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/view/favorite_screen/favorite_screen.dart';
import 'package:shop_app/view/product_list_screen/product_list_screen.dart';

import '../../service/impl/google_signin.dart';
import 'custom_drawer.dart';
import '../profile_screen/profile_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  static const String _appBarLabel = 'Shop';
  static const String _productsLabel = 'Products';
  static const String _favoriteLabel = 'Favorite';
  static const String _profileLabel = 'Profile';
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ProductListScreen(),
    FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_appBarLabel),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<GoogleSignInService>(context, listen: false).logout();
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: _productsLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: _favoriteLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: _profileLabel,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

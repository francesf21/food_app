import 'package:flutter/material.dart';

import 'package:food_app/res/components/components.dart';
import 'package:food_app/view/home_screen/navigator/navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexPage = 0;

  final _widgetOptions = [
    const HomePage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  Future<void> _onIndexPage(int index) async {
    _indexPage = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigatorAppBar(
        onIndexPage: _onIndexPage,
        indexPage: _indexPage,
      ),
      body: _widgetOptions.elementAt(_indexPage),
    );
  }
}

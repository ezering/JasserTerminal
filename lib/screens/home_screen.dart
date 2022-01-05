// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/product/add_product_screen.dart';
import '/screens/categories_screen.dart';
import '/screens/dashboard_screen.dart';
import 'infos_screen.dart';
import '/screens/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: _buildPage(),
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddProductScreen.routeName);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _buildBottomBarButton(
                      0, 'Accueil', Icons.space_dashboard_rounded),
                  _buildBottomBarButton(1, 'Catégories', Icons.category_rounded)
                ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBottomBarButton(2, 'Scan', Icons.qr_code_2_outlined),
                    _buildBottomBarButton(
                        3, 'Infos', Icons.info_outline_rounded),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildPage() {
    switch (currentTab) {
      case 0:
        return DashboardScreen();
      case 1:
        return CategoryScreen();
      case 2:
        return ScanScreen();
      default:
        return InfoScreen();
    }
  }

  _buildBottomBarButton(int index, String title, IconData icon) {
    return MaterialButton(
      minWidth: 40.0,
      onPressed: () {
        setState(() {
          currentTab = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: currentTab == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          Text(
            title,
            style: TextStyle(
              color: currentTab == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

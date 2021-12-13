// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '/screens/categories_screen.dart';
import '/screens/dashboard_screen.dart';
import '/screens/info_screen.dart';
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
          // Navigator.pushNamed(context, '/add');
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
                  _buildBottomBarButton(1, 'Categories', Icons.category_rounded)
                ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBottomBarButton(
                        2, 'Scan', Icons.center_focus_weak_rounded),
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
            color: currentTab == index ? Colors.blue : Colors.grey,
          ),
          Text(
            title,
            style: TextStyle(
              color: currentTab == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/product/add_product_screen.dart';
import 'package:jasser_terminal/widgets/products/add_product_form.dart';
import 'package:jasser_terminal/widgets/products/modal_sheet_add_product.dart';
import 'commandes_screen.dart';
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
        child: const Icon(Icons.add),
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   enableDrag: true,
          //   backgroundColor: Colors.transparent,
          //   isScrollControlled: true,
          //   builder: (context) {
          //     return const ModalAddProductForm();
          //   },
          // );

          Navigator.of(context).pushNamed(AddProductScreen.routeName);
          // const AddProductForm();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: SizedBox(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _buildBottomBarButton(
                      0, 'Accueil', Icons.space_dashboard_rounded),
                  _buildBottomBarButton(
                      1, 'Commandes', Icons.line_style_rounded)
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
        return const DashboardScreen();
      case 1:
        return const CommandeScreen();
      case 2:
        return const ScanScreen();
      default:
        return const InfoScreen();
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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:jasser_terminal/screens/shop/shop_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  Future<void> _refreshShops(BuildContext context) async {
    await Provider.of<Shops>(context, listen: false).fetchAndSetShops();
  }

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Acceuil'),
        ),
        body: RefreshIndicator(
            onRefresh: () => _refreshShops(context),
            child: const ShopScreen()));
  }
}

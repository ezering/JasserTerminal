import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:jasser_terminal/screens/shop/shop_screen.dart';
import 'package:jasser_terminal/widgets/shop/add_shop_buton.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  Future<void> _refreshShops(BuildContext context) async {
    await Provider.of<Shops>(context, listen: false).fetchAndSetShops();
  }

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<Commandes>(context, listen: false).fetchAndSetCommandes();
    // Provider.of<Commandes>(context, listen: false).deleteAllCommandes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceuil'),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () => _refreshShops(context),
          child: Column(
            children: const [
              ShopScreen(),
              AddShopButton(),
            ],
          ),
        ),
      ),
    );
  }
}

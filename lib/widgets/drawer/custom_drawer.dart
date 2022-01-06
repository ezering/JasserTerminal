import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/auth.dart';
import 'package:jasser_terminal/screens/commandes_screen.dart';
import 'package:jasser_terminal/screens/home_screen.dart';
import 'package:jasser_terminal/screens/infos_screen.dart';
import 'package:jasser_terminal/screens/shop/shop_screen.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Jasser Terminal'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Acceuil'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_business_rounded),
            title: const Text('Mes Boutiques'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ShopScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.category_rounded),
            title: const Text('Catégories'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CommandeScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.qr_code_2_outlined),
            title: const Text('Scanner'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CommandeScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title: const Text('Commandes'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Informations'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(InfoScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Deconnexion'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}

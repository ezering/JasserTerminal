import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/auth.dart';
import 'package:jasser_terminal/screens/commandes_screen.dart';
import 'package:jasser_terminal/screens/dashboard_screen.dart';
import 'package:jasser_terminal/screens/home_screen.dart';
import 'package:jasser_terminal/screens/infos_screen.dart';
import 'package:jasser_terminal/screens/scan_screen.dart';
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
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.qr_code_2_outlined),
            title: const Text('Scanner'),
            onTap: () {
              Navigator.of(context).pushNamed(ScanScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined),
            title: const Text('Commandes'),
            onTap: () {
              Navigator.of(context).pushNamed(CommandeScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Compte'),
            onTap: () {
              Navigator.of(context).pushNamed(InfoScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Deconnexion'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
    );
  }
}

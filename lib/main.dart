import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:jasser_terminal/screens/auth/forgot_pass_screen.dart';
import 'package:jasser_terminal/screens/commandes/commande_products_screen.dart';
import 'package:jasser_terminal/screens/commandes/commande_screen.dart';
import 'package:jasser_terminal/screens/product/add_product_screen.dart';
import 'package:jasser_terminal/screens/product/edit_product_screen.dart';
import 'package:jasser_terminal/screens/product/product_detail_screen.dart';
import 'package:jasser_terminal/screens/product/quick_add_product.dart';
import 'package:jasser_terminal/screens/shelf/add_shelf_screen.dart';
import 'package:jasser_terminal/screens/shelf/edit_shelf_screen.dart';
import 'package:jasser_terminal/screens/shelf/shelf_products_screen.dart';
import 'package:jasser_terminal/screens/shelf/shelf_screen.dart';
import 'package:jasser_terminal/screens/shop/add_shop_screen.dart';
import 'package:jasser_terminal/screens/shop/edit_shop_screen.dart';
import 'package:jasser_terminal/screens/shop/shop_screen.dart';
import 'package:jasser_terminal/screens/splash_screen.dart';
import 'package:jasser_terminal/widgets/commandes/commande_product.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'screens/auth/authentication_screen.dart';
import 'screens/commandes_screen.dart';
import 'screens/infos_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Shops()),
        ChangeNotifierProvider(create: (context) => Shelfs()),
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Commandes()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Jasser Terminal',
          theme: ThemeData(
            fontFamily: 'QuickSand',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.cyan),
            canvasColor: const Color.fromRGBO(255, 254, 240, 1),
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  bodyText2: const TextStyle(
                    color: Colors.black,
                  ),
                  subtitle1: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle2: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  headline1: const TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                  headline6: const TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                  button: const TextStyle(
                    color: Colors.white,
                  ),
                ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? const HomeScreen()
              : FutureBuilder(
                  future: auth.autoAuthenticate(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthenticationScreen(),
                ),
          routes: {
            AuthenticationScreen.routeName: (context) =>
                const AuthenticationScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            CommandeScreen.routeName: (context) => const CommandeScreen(),
            ScanScreen.routeName: (context) => const ScanScreen(),
            InfoScreen.routeName: (context) => const InfoScreen(),
            ForgotPassScreen.routeName: (context) => const ForgotPassScreen(),
            ShopScreen.routeName: (context) => const ShopScreen(),
            ShelfScreen.routeName: (context) => const ShelfScreen(),
            ShelfProducts.routeName: (context) => const ShelfProducts(),
            // ShelfList.routeName: (context) => const ShelfList(),
            ProductDetailsScreen.routeName: (context) =>
                const ProductDetailsScreen(),
            AddProductScreen.routeName: (context) => const AddProductScreen(),
            QuickAddProductScreen.routeName: (context) =>
                const QuickAddProductScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
            CommandeScreenList.routeName: (context) =>
                const CommandeScreenList(),
            CommandeProducts.routeName: (context) => const CommandeProducts(),
            CommandeProductList.routeName: (context) =>
                const CommandeProductList(),
            AddShopScreen.routeName: (context) => const AddShopScreen(),
            EditShopScreen.routeName: (context) => const EditShopScreen(),
            AddShelfScreen.routeName: (context) => const AddShelfScreen(),
            EditShelfScreen.routeName: (context) => const EditShelfScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

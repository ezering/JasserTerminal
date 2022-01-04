import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:jasser_terminal/screens/auth/forgot_pass_screen.dart';
import 'package:jasser_terminal/screens/category/category_products_screen.dart';
import 'package:jasser_terminal/screens/category/category_screen.dart';
import 'package:jasser_terminal/screens/product/product_detail_screen.dart';
import 'package:jasser_terminal/screens/shelf/add_shelf_screen.dart';
import 'package:jasser_terminal/screens/shelf/edit_shelf_screen.dart';
import 'package:jasser_terminal/screens/shelf/shelf_products_screen.dart';
import 'package:jasser_terminal/screens/shelf/shelf_screen.dart';
import 'package:jasser_terminal/screens/shop/add_shop_screen.dart';
import 'package:jasser_terminal/screens/shop/edit_shop_screen.dart';
import 'package:jasser_terminal/screens/shop/shop_screen.dart';
import 'package:jasser_terminal/screens/splash_screen.dart';
import 'package:jasser_terminal/widgets/products/category_product.dart';
import 'package:jasser_terminal/widgets/shelf/shelf_list.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'screens/auth/authentication_screen.dart';
import 'screens/categories_screen.dart';
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
            CategoryScreen.routeName: (context) => const CategoryScreen(),
            ScanScreen.routeName: (context) => const ScanScreen(),
            InfoScreen.routeName: (context) => const InfoScreen(),
            ForgotPassScreen.routeName: (context) => const ForgotPassScreen(),
            ShopScreen.routeName: (context) => const ShopScreen(),
            ShelfScreen.routeName: (context) => const ShelfScreen(),
            ShelfProducts.routeName: (context) => const ShelfProducts(),
            ShelfList.routeName: (context) => const ShelfList(),
            ProductDetailsScreen.routeName: (context) =>
                const ProductDetailsScreen(),
            CategoryScreenList.routeName: (context) =>
                const CategoryScreenList(),
            CategoryProducts.routeName: (context) => const CategoryProducts(),
            CategoryProductList.routeName: (context) =>
                const CategoryProductList(),
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

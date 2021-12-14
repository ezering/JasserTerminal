import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/auth/forgot_pass_screen.dart';
import 'package:jasser_terminal/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/info_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/auth/home_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: prefer_const_literals_to_create_immutables
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
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
                  headline6: const TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  button: const TextStyle(
                    color: Colors.white,
                  ),
                ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth ? const HomeScreen() : const AuthHomeScreen(),
          routes: {
            AuthHomeScreen.routeName: (context) => const AuthHomeScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            CategoryScreen.routeName: (context) => const CategoryScreen(),
            ScanScreen.routeName: (context) => const ScanScreen(),
            InfoScreen.routeName: (context) => const InfoScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            ForgotPassScreen.routeName: (context) => const ForgotPassScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

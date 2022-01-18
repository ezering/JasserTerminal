import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/auth.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatelessWidget {
  static const routeName = '/info';

  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                // height: 350,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      const CircleAvatar(
                        child: Text("Ezer"),
                        radius: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Eben Ezeer INGANJI",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                        ),
                        onPressed: () {
                          Provider.of<Auth>(context, listen: false).logout();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Se déconnecter",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      // Card(
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 5, vertical: 5),
                      //   clipBehavior: Clip.antiAlias,
                      //   color: Colors.white,
                      //   elevation: 5,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 8, vertical: 22),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Boutique",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "#1",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Etagères",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "8",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Produits",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "152",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Card(
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 5, vertical: 5),
                      //   clipBehavior: Clip.antiAlias,
                      //   color: Colors.white,
                      //   elevation: 5,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 8, vertical: 22),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Boutique",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "#2",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Etagères",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "14",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Produits",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "105",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Card(
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 5, vertical: 5),
                      //   clipBehavior: Clip.antiAlias,
                      //   color: Colors.white,
                      //   elevation: 5,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 8, vertical: 22),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Boutique",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "#3",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Etagères",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "36",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: <Widget>[
                      //               Text(
                      //                 "Produits",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //               Text(
                      //                 "204",
                      //                 style:
                      //                     Theme.of(context).textTheme.bodyText1,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

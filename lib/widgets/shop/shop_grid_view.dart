import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:jasser_terminal/screens/shelf/shelf_screen.dart';
import 'package:jasser_terminal/screens/shop/add_shop_screen.dart';
import 'package:jasser_terminal/screens/shop/edit_shop_screen.dart';
import 'package:jasser_terminal/widgets/swipe/delete_swipe.dart';
import 'package:jasser_terminal/widgets/swipe/edit_swipe.dart';
import 'package:provider/provider.dart';

class ShopGridView extends StatelessWidget {
  const ShopGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopData = Provider.of<Shops>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: shopData.shops.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(shopData.shops[index].id),
        background: const EditSwipe(),
        secondaryBackground: const DeleteSwipe(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            final bool res = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:
                        const Text("Etes-vous sûr que vous voulez supprimer?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          "Annuler",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Supprimer",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            return res;
          } else {
            // Allez Sur la page Editer;
            Navigator.of(context).pushNamed(EditShopScreen.routeName);
          }
        },
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(ShelfScreen.routeName);
          },
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  shopData.shops[index].name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 10),
                Text(
                  shopData.shops[index].address,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 4 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );

    // return GridView(
    //   padding: const EdgeInsets.all(10),
    //   children: [
    //     // FutureBuilder(
    //     //   future: futureShop,
    //     //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     //     if (snapshot.connectionState == ConnectionState.waiting) {
    //     //       const Center(child: Text('Loading...'));
    //     //     }
    //     //     if (snapshot.hasData) {
    //     //       return const Text('data');
    //     //     }
    //     //     if (!snapshot.hasData) {
    //     //       return const Center(child: Text('No data found'));
    //     //     }
    //     //     if (snapshot.hasError) {
    //     //       Center(child: Text('${snapshot.error}'));
    //     //     }
    //     //     // By default, show a loading spinner.
    //     //     return const Center(child: Text('Default'));
    //     //   },
    //     // ),
    //     Dismissible(
    //       key: const ValueKey('1'),
    //       background: const EditSwipe(),
    //       secondaryBackground: const DeleteSwipe(),
    //       confirmDismiss: (direction) async {
    //         if (direction == DismissDirection.endToStart) {
    //           final bool res = await showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   content: const Text(
    //                       "Etes-vous sûr que vous voulez supprimer?"),
    //                   actions: <Widget>[
    //                     TextButton(
    //                       child: const Text(
    //                         "Annuler",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                     TextButton(
    //                       child: const Text(
    //                         "Supprimer",
    //                         style: TextStyle(color: Colors.red),
    //                       ),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               });
    //           return res;
    //         } else {
    //           // Allez Sur la page Editer;
    //           Navigator.of(context).pushNamed(EditShopScreen.routeName);
    //         }
    //       },
    //       child: InkWell(
    //         onTap: () {
    //           Navigator.of(context).pushNamed(ShelfScreen.routeName);
    //         },
    //         splashColor: Theme.of(context).primaryColor,
    //         borderRadius: BorderRadius.circular(10),
    //         child: Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.all(10),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 "Boutique #1",
    //                 style: Theme.of(context).textTheme.headline1,
    //               ),
    //               const SizedBox(height: 10),
    //               Text(
    //                 "Tournai - Belgique",
    //                 style: Theme.of(context).textTheme.bodyText1,
    //               ),
    //             ],
    //           ),
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [
    //                 Theme.of(context).colorScheme.primary,
    //                 Theme.of(context).colorScheme.secondary,
    //               ],
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //             ),
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //         ),
    //       ),
    //     ),

    //     Dismissible(
    //       key: const ValueKey('1'),
    //       background: const EditSwipe(),
    //       secondaryBackground: const DeleteSwipe(),
    //       confirmDismiss: (direction) async {
    //         if (direction == DismissDirection.endToStart) {
    //           final bool res = await showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   content: const Text(
    //                       "Etes-vous sûr que vous voulez supprimer?"),
    //                   actions: <Widget>[
    //                     TextButton(
    //                       child: const Text(
    //                         "Annuler",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                     TextButton(
    //                       child: const Text(
    //                         "Supprimer",
    //                         style: TextStyle(color: Colors.red),
    //                       ),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               });
    //           return res;
    //         } else {
    //           // Allez Sur la page Editer;
    //           Navigator.of(context).pushNamed(EditShopScreen.routeName);
    //         }
    //       },
    //       child: InkWell(
    //         onTap: () {
    //           Navigator.of(context).pushNamed(ShelfScreen.routeName);
    //         },
    //         splashColor: Theme.of(context).primaryColor,
    //         borderRadius: BorderRadius.circular(10),
    //         child: Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.all(10),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 "Boutique #2",
    //                 style: Theme.of(context).textTheme.headline1,
    //               ),
    //               const SizedBox(height: 10),
    //               Text(
    //                 "Mouscron - Belgique",
    //                 style: Theme.of(context).textTheme.bodyText1,
    //               ),
    //             ],
    //           ),
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [
    //                 Theme.of(context).colorScheme.primary,
    //                 Theme.of(context).colorScheme.secondary,
    //               ],
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //             ),
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //         ),
    //       ),
    //     ),

    //     // Pour ajouter une boutique supplementaire
    //     InkWell(
    //       onTap: () {
    //         Navigator.of(context).pushNamed(AddShopScreen.routeName);
    //       },
    //       splashColor: Theme.of(context).primaryColor,
    //       borderRadius: BorderRadius.circular(10),
    //       child: Container(
    //         padding: const EdgeInsets.all(10),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Column(
    //               children: [
    //                 IconButton(
    //                   onPressed: () {},
    //                   icon: const Icon(Icons.add_business_rounded, size: 50),
    //                   color: Theme.of(context).colorScheme.secondary,
    //                 ),
    //                 const SizedBox(height: 10),
    //                 Text("Ajouter Une Boutique",
    //                     style: Theme.of(context).textTheme.headline6),
    //               ],
    //             ),
    //           ],
    //         ),
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //             colors: [
    //               Theme.of(context).colorScheme.primary,
    //               Theme.of(context).colorScheme.secondary,
    //             ],
    //             begin: Alignment.topLeft,
    //             end: Alignment.bottomRight,
    //           ),
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //       ),
    //     ),
    //   ],
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 1,
    //     childAspectRatio: 4 / 2,
    //     crossAxisSpacing: 10,
    //     mainAxisSpacing: 10,
    //   ),
    // );
  }
}

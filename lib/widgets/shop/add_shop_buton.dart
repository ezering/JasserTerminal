import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/shop/add_shop_screen.dart';

class AddShopButton extends StatelessWidget {
  const AddShopButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AddShopScreen.routeName);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_business_rounded, size: 50),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 10),
                Text("Ajouter Une Boutique",
                    style: Theme.of(context).textTheme.headline6),
              ],
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
    );
  }
}

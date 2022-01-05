import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/products/product_detail.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du produit'),
      ),
      body: ProductDetails(singleProductData: loadedProduct),
      drawer: const CustomDrawer(),
    );
  }
}

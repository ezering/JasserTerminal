import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/products.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/products/shelf_products.dart';
import 'package:provider/provider.dart';

class ShelfProducts extends StatefulWidget {
  static const routeName = '/shelf-products';
  const ShelfProducts({Key? key}) : super(key: key);

  @override
  State<ShelfProducts> createState() => _ShelfProductsState();
}

class _ShelfProductsState extends State<ShelfProducts> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    final shelfId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedShelf =
        Provider.of<Shelfs>(context, listen: false).findById(shelfId);
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(loadedShelf);
  }

  @override
  void didChangeDependencies() {
    final shelfId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedShelf =
        Provider.of<Shelfs>(context, listen: false).findById(shelfId);
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<Products>(context)
            .fetchAndSetProducts(loadedShelf)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        Display.dialogError(context, error);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits sur étagère'),
      ),
      body: _isLoading
          ? Container(
              padding: const EdgeInsets.all(40),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: const ShelfProductsList()),
      drawer: const CustomDrawer(),
    );
  }
}

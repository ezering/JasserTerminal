import 'package:flutter/material.dart';
import 'package:jasser_terminal/providers/shops.dart';
import 'package:jasser_terminal/widgets/shop/shop_grid_view.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  static const routeName = '/shop';
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  var _isInit = true; // pour ne pas charger les données deux fois
  var _isLoading = false;
  // late Future<List<Shop>> futureShop = [] as Future<List<Shop>>;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Shops>(context).fetchAndSetShops().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : const ShopGridView();
  }
}

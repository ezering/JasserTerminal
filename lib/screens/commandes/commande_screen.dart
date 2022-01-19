import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/commandes.dart';
import 'package:jasser_terminal/widgets/commandes/comande_shop_grid_view.dart';
import 'package:provider/provider.dart';

class CommandeScreenList extends StatefulWidget {
  static const routeName = '/commandes-screen-list';
  const CommandeScreenList({Key? key}) : super(key: key);

  @override
  State<CommandeScreenList> createState() => _CommandeScreenListState();
}

class _CommandeScreenListState extends State<CommandeScreenList> {
  var _isInit = true;
  var _isLoading = false;

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
      try {
        Provider.of<Commandes>(context).fetchAndSetCommandes().then((_) {
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
    return _isLoading
        ? Container(
            padding: const EdgeInsets.all(60),
            child: const Center(child: CircularProgressIndicator()),
          )
        : const CommandeShopGridView();
  }
}
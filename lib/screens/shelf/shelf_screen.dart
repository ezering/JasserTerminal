import 'package:flutter/material.dart';
import 'package:jasser_terminal/models/display.dart';
import 'package:jasser_terminal/providers/shelfs.dart';
import 'package:jasser_terminal/widgets/drawer/custom_drawer.dart';
import 'package:jasser_terminal/widgets/shelf/add_shelf_button.dart';
import 'package:jasser_terminal/widgets/shelf/shelf_list.dart';
import 'package:provider/provider.dart';

class ShelfScreen extends StatefulWidget {
  static const routeName = '/shelf';
  const ShelfScreen({Key? key}) : super(key: key);

  @override
  State<ShelfScreen> createState() => _ShelfScreenState();
}

class _ShelfScreenState extends State<ShelfScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshShelfs(BuildContext context) async {
    await Provider.of<Shelfs>(context, listen: false).fetchAndSetShelfs();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<Shelfs>(context).fetchAndSetShelfs().then((_) {
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
        title: const Text('Etagère'),
      ),
      body: _isLoading
          ? Container(
              padding: const EdgeInsets.all(40),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshShelfs(context),
              child: Column(
                children: const [
                  ShelfList(),
                  AddShelfButton(),
                ],
              )),
      drawer: const CustomDrawer(),
    );
  }
}

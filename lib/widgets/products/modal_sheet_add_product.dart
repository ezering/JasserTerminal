import 'package:flutter/material.dart';
import 'package:jasser_terminal/screens/product/add_product_screen.dart';
import 'package:jasser_terminal/widgets/products/add_product_form.dart';

class ModalAddProductForm extends StatelessWidget {
  const ModalAddProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                WelcomeTextAddProduct(),
                AddProductForm(),
              ],
            ),
          ),
        );
      },
    );
  }
}

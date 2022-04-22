import 'package:flutter/material.dart';
import 'package:shop_app/view/common_widget/product_list_widget.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: ProductListWidget(
        isAllProductRequest: true,
      ),
    );
  }
}

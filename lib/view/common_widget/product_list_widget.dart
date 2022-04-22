import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../../models/product.dart';
import '../../repository/db_helper.dart';
import '../product_screen/product_screen.dart';

class ProductListWidget extends StatefulWidget {
  final bool isAllProductRequest;

  const ProductListWidget({Key? key, required this.isAllProductRequest})
      : super(key: key);

  @override
  _ProductListWidgetState createState() =>
      _ProductListWidgetState(isAllProductRequest: this.isAllProductRequest);
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final bool isAllProductRequest;
  final DBHelper _dbHelper = DBHelper.instance;
  List<Product> searchedProductList = <Product>[];
  ProductController productsController = Get.put(ProductController());

  _ProductListWidgetState({required this.isAllProductRequest});

  @override
  Widget build(BuildContext context) {
    return _productList();
  }

  Widget _productList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
          future: _fetchProductList(isAllProductsRequest: isAllProductRequest),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              searchedProductList = snapshot.data;
              return _buildProductsList(productList: searchedProductList);
            }
          }),
    );
  }

  Future<List<Product>> _fetchProductList(
      {required bool isAllProductsRequest}) async {
    if (isAllProductsRequest) {
      List<Product> productList = await _dbHelper.getProductList();
      if (productList.isEmpty) {
        while (productsController.loading.value) {
          await Future.delayed(const Duration(seconds: 5), () {});
        }
      }
      return await _dbHelper.getProductList();
    }
    return await _dbHelper.getFavoriteProductList();
  }

  ListView _buildProductsList({required List<Product> productList}) {
    return ListView.builder(
      itemCount: productList.length,
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) => InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            _routePage(
              ProductScreen(
                title: productList[index].title,
                price: productList[index].price,
                description: productList[index].description,
                category: productList[index].category,
                image: productList[index].image,
              ),
            ),
          );
        },
        child: Card(
          color: Colors.grey,
          elevation: 0.0,
          child: Container(
            height: 140,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(productList[index].image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  flex: 3,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productList[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          "\$${productList[index].price}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Column(
                    children: [
                      FavoriteButton(
                        isFavorite: productList[index].isFavorite == 1,
                        valueChanged: (_isFavorite) async {
                          await _dbHelper.updateProduct(Product(
                            id: productList[index].id,
                            title: productList[index].title,
                            price: productList[index].price,
                            description: productList[index].description,
                            category: productList[index].category,
                            image: productList[index].image,
                            isFavorite: _isFavorite ? 1 : 0,
                          ));
                        },
                      ),
                      const SizedBox(),
                    ],
                  ),
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route _routePage(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => screen,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

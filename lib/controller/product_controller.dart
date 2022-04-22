import 'package:get/get.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repository/impl/product_repository_impl.dart';

import '../repository/db_helper.dart';

class ProductController extends GetxController {
  final ProductRepositoryImpl _productRepository = ProductRepositoryImpl();
  RxBool loading = false.obs;
  List products = [].obs;
  var showGrid = false.obs;
  final DBHelper _dbHelper = DBHelper.instance;

  ProductController() {
    _fetchApiData();
  }

  _fetchApiData() async {
    loading(true);
    List<Product> dbProductList = await _dbHelper.getProductList();
    if (dbProductList.isEmpty) {
      products = await _productRepository.fetchApiData();
      for (var element in products) {
        await _dbHelper.insertProduct(Product(
            id: element['id'],
            title: element['title'],
            price: element['price'] + .0,
            description: element['description'],
            category: element['category'],
            image: element['image'],
            isFavorite: 0));
      }
    }
    loading(false);
  }

  toggleGrid() {
    showGrid(!showGrid.value);
  }
}

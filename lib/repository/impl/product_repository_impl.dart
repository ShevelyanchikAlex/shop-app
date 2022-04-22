import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final apiUrl = "https://fakestoreapi.com/products";

  @override
  fetchApiData() async {
    var response = await http.get(Uri.parse(apiUrl));
    return json.decode(response.body);
  }
}

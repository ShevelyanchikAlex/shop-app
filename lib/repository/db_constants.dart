class DBConstants {
  static const String productsDB = 'products.db';

  static const String productTable = 'product_table';
  static const String productId = 'id';
  static const String productTile = 'title';
  static const String productPrice = 'price';
  static const String productDescription = 'description';
  static const String productCategory = 'category';
  static const String productImage = 'image';
  static const String productIsFavorite = 'is_favorite';

  static const String createProductTable = '''
      create table $productTable(
      $productId integer primary key autoincrement,
      $productTile text,
      $productPrice real,
      $productDescription text,
      $productCategory text,
      $productImage text,
      $productIsFavorite integer)
      ''';
}

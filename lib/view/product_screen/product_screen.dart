import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String appBarLabel = 'About Product';
  static const String priceLabel = 'Price: ';
  static const String categoryLabel = 'Category: ';
  static const String descriptionLabel = 'Description: ';

  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  const ProductScreen(
      {Key? key,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appBarLabel),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
              ),
            ),
            margin: const EdgeInsets.all(10.0),
          ),
          flex: 3,
        ),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 25.0,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 25.0,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          priceLabel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '\$' + price.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 25.0,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          categoryLabel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 25.0,
                    ),
                    child: Row(
                      children: const [
                        Text(
                          descriptionLabel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 25.0,
                    ),
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          ),
          flex: 5,
        ),
      ],
    );
  }
}

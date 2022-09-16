import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/product_item.dart';
import 'package:gerenciamento_estado/data/dummy_data.dart';
import 'package:gerenciamento_estado/models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Minha loja'),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: loadedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: ((context, index) =>
              ProductItem(product: loadedProducts[index]))),
    );
  }
}

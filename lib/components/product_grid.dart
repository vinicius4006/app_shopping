import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/product_item.dart';
import 'package:gerenciamento_estado/models/product.dart';
import 'package:gerenciamento_estado/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid({Key? key, required this.showFavoriteOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build ProductGrid');
    final List<Product> loadedProducts = context.select((ProductList value) =>
        showFavoriteOnly ? value.favoriteItems : value.items);
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            value: loadedProducts[index], child: const ProductItem())));
  }
}

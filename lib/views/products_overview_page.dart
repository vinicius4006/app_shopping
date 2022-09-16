import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/product_grid.dart';
import 'package:gerenciamento_estado/models/product_list.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build ProductsOverviewPage');
    final provider = context.read<ProductList>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Minha loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Todos'),
              )
            ],
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.Favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showFavoriteAll();
              }
            },
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}

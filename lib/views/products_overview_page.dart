import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/badge.dart';
import 'package:gerenciamento_estado/components/product_grid.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';

// ignore: constant_identifier_names
enum FilterOptions { Favorite, All }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    debugPrint('Build ProductsOverviewPage');

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
                setState(() {
                  _showFavoriteOnly = true;
                });
              } else {
                setState(() {
                  _showFavoriteOnly = false;
                });
              }
            },
          ),
          Badge(
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.CART);
                  },
                  icon: const Icon(Icons.shopping_cart))),
        ],
      ),
      body: ProductGrid(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}

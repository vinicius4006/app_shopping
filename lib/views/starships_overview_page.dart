import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/app_drawer.dart';
import 'package:gerenciamento_estado/components/badge.dart';
import 'package:gerenciamento_estado/components/startship_grid.dart';
import 'package:gerenciamento_estado/models/starship_list.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
enum FilterOptions { Favorite, All }

class StarshipsOverviewPage extends StatefulWidget {
  const StarshipsOverviewPage({Key? key}) : super(key: key);

  @override
  State<StarshipsOverviewPage> createState() => _StarshipsOverviewPageState();
}

class _StarshipsOverviewPageState extends State<StarshipsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<StarshipList>().loadStarships().then((value) {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build ProductsOverviewPage');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Starships'),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StarshipGrid(showFavoriteOnly: _showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}

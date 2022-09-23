import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/startship_grid_item.dart';
import 'package:gerenciamento_estado/models/starship.dart';
import 'package:gerenciamento_estado/models/starship_list.dart';
import 'package:provider/provider.dart';

class StarshipGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const StarshipGrid({Key? key, required this.showFavoriteOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build ProductGrid');
    final List<Starship> loadedProducts = context.select((StarshipList value) =>
        showFavoriteOnly ? value.favoriteItems : value.items);

    return loadedProducts.isEmpty
        ? const Center(
            child: Text('Sem starships salvas'),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: loadedProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                value: loadedProducts[index],
                child: const StarshipGridItem())));
  }
}

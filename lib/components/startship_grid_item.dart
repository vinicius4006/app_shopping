import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart.dart';
import 'package:gerenciamento_estado/models/starship.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

class StarshipGridItem extends StatelessWidget {
  const StarshipGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build ProductItem');

    final cart = context.read<Cart>();

    return Consumer<Starship>(
      builder: (context, starship, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              color: Theme.of(context).errorColor,
              onPressed: () {
                starship.toggleFavorite();
              },
              icon: Icon(
                  starship.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                starship.name,
                textAlign: TextAlign.center,
              ),
            ),
            trailing: IconButton(
                color: Theme.of(context).errorColor,
                onPressed: () {
                  if (starship.costInCredits != 0) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${starship.name} no carrinho'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                          label: 'DESFAZER',
                          textColor: Colors.white,
                          onPressed: () {
                            cart.removeSingleItem(starship.id);
                          }),
                    ));
                    cart.addItem(starship);
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Indisponível'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                icon: const Icon(Icons.shopping_cart)),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.STARSHIP_DETAIL,
                  arguments: starship);
            },
            child: Image.network(
              starship.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

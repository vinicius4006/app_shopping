import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/exceptions/http_Exception.dart';
import 'package:gerenciamento_estado/models/auth.dart';
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
    final msg = ScaffoldMessenger.of(context);
    final auth = context.read<Auth>();
    return Consumer<Starship>(
      builder: (context, starship, child) => Hero(
        tag: starship..id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading: IconButton(
                color: Theme.of(context).errorColor,
                onPressed: () async {
                  try {
                    await starship.toggleFavorite(auth.token!, auth.userId!);
                  } on HttpException catch (error) {
                    msg.hideCurrentSnackBar();
                    msg.showSnackBar(SnackBar(content: Text(error.toString())));
                  }
                },
                icon: Icon(starship.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
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
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/star_draw.jpg'),
                image: NetworkImage(starship.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

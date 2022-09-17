import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart.dart';
import 'package:gerenciamento_estado/models/product.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build ProductItem');
    //final product = context.read<Product>();
    final cart = context.read<Cart>();

    return Consumer<Product>(
      builder: (context, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              color: Theme.of(context).errorColor,
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                product.name,
                textAlign: TextAlign.center,
              ),
            ),
            trailing: IconButton(
                color: Theme.of(context).errorColor,
                onPressed: () {
                  cart.addItem(product);
                },
                icon: const Icon(Icons.shopping_cart)),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.PRODUCT_DETAIL,
                  arguments: product);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

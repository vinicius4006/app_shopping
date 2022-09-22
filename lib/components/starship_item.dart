import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/starship.dart';

class StarshipItem extends StatelessWidget {
  final Starship starship;
  const StarshipItem({super.key, required this.starship});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(starship.imageUrl),
      ),
      title: Text(starship.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}

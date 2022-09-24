import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/exceptions/http_Exception.dart';
import 'package:gerenciamento_estado/models/starship.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/starship_list.dart';

class StarshipItem extends StatelessWidget {
  final Starship starship;
  const StarshipItem({super.key, required this.starship});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
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
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.STARSHIPS_FORM,
                      arguments: starship);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) => AlertDialog(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                              'Deseja realmente excluir a ${starship.name} ?',
                              textAlign: TextAlign.center,
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'NÃO',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      try {
                                        await context
                                            .read<StarshipList>()
                                            .deleteStarship(starship.id);
                                      } on HttpException catch (error) {
                                        msg.hideCurrentSnackBar();
                                        msg.showSnackBar(SnackBar(
                                            content: Text(error.toString())));
                                      }
                                    },
                                    child: const Text('SIM',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          )));
                },
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

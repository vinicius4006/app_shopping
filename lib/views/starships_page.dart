import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/app_drawer.dart';
import 'package:gerenciamento_estado/components/starship_item.dart';
import 'package:gerenciamento_estado/models/starship_list.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

class StarshipsPage extends StatelessWidget {
  const StarshipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StarshipList starships = context.watch<StarshipList>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Starships'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.STARSHIPS_FORM);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: starships.itemsCount,
            itemBuilder: (ctx, index) => Column(
                  children: [
                    StarshipItem(
                      starship: starships.items[index],
                    ),
                    const Divider()
                  ],
                )),
      ),
    );
  }
}

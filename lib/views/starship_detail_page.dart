import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/starship.dart';

class StarshipDetailPage extends StatelessWidget {
  const StarshipDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Starship starship =
        ModalRoute.of(context)!.settings.arguments as Starship;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(starship.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: starship.id,
                    child: Image.network(
                      starship.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment(0, 0.8),
                              end: Alignment(0, 0),
                              colors: [
                        Color.fromARGB(153, 105, 80, 8),
                        Color.fromRGBO(0, 0, 0, 0)
                      ])))
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 10,
            ),
            Text(
              '${starship.costInCredits == 0 ? 'unknown' : starship.costInCredits} credits ',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                starship.model,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                starship.manufacturer,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '${starship.size}',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '${starship.passengers}',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 1000,
            ),
            const Text('OPA')
          ]))
        ],
      ),
    );
  }
}

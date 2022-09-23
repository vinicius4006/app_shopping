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
      appBar: AppBar(
        centerTitle: true,
        title: Text(starship.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                starship.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${starship.costInCredits == 0 ? 'unknown' : starship.costInCredits} credits ',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                starship.manufacturer,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

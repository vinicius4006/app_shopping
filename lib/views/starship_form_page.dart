import 'package:flutter/material.dart';

class StarshipFormPage extends StatefulWidget {
  const StarshipFormPage({super.key});

  @override
  State<StarshipFormPage> createState() => _StarshipFormPageState();
}

class _StarshipFormPageState extends State<StarshipFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário da Starship')),
      body: Form(
          child: ListView(
        children: const [],
      )),
    );
  }
}

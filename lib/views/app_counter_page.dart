import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);
    debugPrint('Build CounterPage');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Exemplo Contador'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(provider!.state.value.toString()),
            IconButton(
                onPressed: () {
                  setState(() {
                    provider.state.inc();
                  });

                  debugPrint('${provider.state.value}');
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    provider.state.dec();
                  });

                  debugPrint('${provider.state.value}');
                },
                icon: const Icon(
                  Icons.remove,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}

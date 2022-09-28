import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF766A65),
              Color(0xFFEDD812),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 60),
                      //cascade operator
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, 2))
                          ],
                          color: Colors.black),
                      child: Text(
                        'Sua Starship',
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'Anton',
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                    const AuthForm()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

  // Exemplo usado para explicar o cascade operator
  // List<int> a = [1,2,3];
  
  // a.add(4);
  // a.add(5);
  // a.add(6);
  
  
  // a..add(7)..add(8)..add(9);

  // print(a);
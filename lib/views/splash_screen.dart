import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/exceptions/http_exception.dart';
import 'package:gerenciamento_estado/models/auth.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      try {
        await context.read<Auth>().checkStorageLogin();
        if (mounted) {
          Navigator.pushNamed(context, AppRoutes.AUTH_OR_HOME);
        }
      } on HttpException catch (error) {
        final msg = ScaffoldMessenger.of(context);
        msg.showSnackBar(SnackBar(
            content: Center(
          child: Text(error.toString()),
        )));
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF766A65),
          Color(0xFFEDD812),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

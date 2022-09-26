import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/auth.dart';
import 'package:gerenciamento_estado/views/auth_page.dart';
import 'package:gerenciamento_estado/views/starships_overview_page.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = context.watch<Auth>();
    return auth.isAuth ? const StarshipsOverviewPage() : const AuthPage();
  }
}

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.stream),
            title: const Text('Starships'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.AUTH_OR_HOME),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.featured_play_list),
            title: const Text('Pedidos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.precision_manufacturing),
            title: const Text('Gerenciar Starships'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.STARSHIPS),
          ),
        ],
      ),
    );
  }
}

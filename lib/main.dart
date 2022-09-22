import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart.dart';
import 'package:gerenciamento_estado/models/order_list.dart';
import 'package:gerenciamento_estado/models/starship_list.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:gerenciamento_estado/views/cart_page.dart';
import 'package:gerenciamento_estado/views/orders_page.dart';
import 'package:gerenciamento_estado/views/starship_detail_page.dart';
import 'package:gerenciamento_estado/views/starship_form_page.dart';
import 'package:gerenciamento_estado/views/starships_overview_page.dart';
import 'package:gerenciamento_estado/views/starships_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StarshipList(),
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Starships',
        theme: ThemeData(
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color.fromARGB(203, 0, 0, 0),
                onPrimary: Colors.yellow,
                secondary: Colors.black87,
                onSecondary: Color.fromARGB(255, 255, 166, 136),
                error: Color(0xffd62957),
                onError: Color.fromARGB(162, 214, 41, 87),
                background: Colors.black87,
                onBackground: Colors.black87,
                surface: Colors.black87,
                onSurface: Colors.black87),
            fontFamily: 'Lato'),
        routes: {
          AppRoutes.HOME: (_) => const StarshipsOverviewPage(),
          AppRoutes.STARSHIP_DETAIL: (_) => const StarshipDetailPage(),
          AppRoutes.CART: (_) => const CartPage(),
          AppRoutes.ORDERS: (_) => const OrderPage(),
          AppRoutes.STARSHIPS: (_) => const StarshipsPage(),
          AppRoutes.STARSHIPS_FORM: (_) => const StarshipFormPage(),
        },
      ),
    );
  }
}

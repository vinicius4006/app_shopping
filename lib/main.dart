import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/product_list.dart';
import 'package:gerenciamento_estado/utils/app_routes.dart';
import 'package:gerenciamento_estado/views/app_product_detail_page.dart';
import 'package:gerenciamento_estado/views/products_overview_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Shopping',
        theme: ThemeData(
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xffbf1e62),
                onPrimary: Colors.white,
                secondary: Color.fromARGB(178, 191, 30, 97),
                onSecondary: Color.fromARGB(255, 255, 166, 136),
                error: Color(0xffd62957),
                onError: Color.fromARGB(162, 214, 41, 87),
                background: Color(0xffbf1e62),
                onBackground: Color(0xffbf1e62),
                surface: Color(0xffbf1e62),
                onSurface: Color(0xffbf1e62)),
            fontFamily: 'Lato'),
        home: const ProductsOverviewPage(),
        routes: {AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage()},
      ),
    );
  }
}

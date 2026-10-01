import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'pages/catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider()..fetchProductsAndCart(),
      child: MaterialApp(
        title: 'Kedai Kopi Digital',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFBF8F5), // Warna Krem Soft
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6F4E37), // Cokelat Espresso
            primary: const Color(0xFF6F4E37),
            secondary: const Color(0xFFD2B48C),
            surface: const Color(0xFFFAF0E6),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF4A3525), // Cokelat Gelap Warm
            foregroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5A2B), // Cokelat Karamel
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        home: const CatalogPage(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir_mandiri_pplgxii5/pages/home_page.dart';
import 'package:tugas_akhir_mandiri_pplgxii5/providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bayyy App Store',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

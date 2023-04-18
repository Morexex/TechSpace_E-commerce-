import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/main_Screens/customer_home.dart';
import 'package:multi_store_app/main_Screens/supplier_home.dart';
import 'package:multi_store_app/main_Screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: WelcomeScreen(),
      initialRoute: '/customerSignup_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/customerHome_screen': (context) => const CustomerHomeScreen(),
        '/supplierHome_screen': (context) => const SupplierHomeScreen(),
        '/customerSignup_screen': (context) => const CustomerRegisterScreen(),
      },
    );
  }
}

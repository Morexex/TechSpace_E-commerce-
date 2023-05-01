import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/auth/supplier_signup.dart';
import 'package:multi_store_app/main_Screens/customer_home.dart';
import 'package:multi_store_app/main_Screens/supplier_home.dart';
import 'package:multi_store_app/main_Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:provider/provider.dart';
import 'auth/customer_login.dart';
import 'auth/supplier_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Cart()),
        ChangeNotifierProvider(create: (_)=>Wish()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: WelcomeScreen(),
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/customer_home': (context) => const CustomerHomeScreen(),
        '/supplier_home': (context) => const SupplierHomeScreen(),
        '/customerSignup_screen': (context) => const CustomerRegisterScreen(),
        '/customerLogin_screen': (context) => const CustomerLoginScreen(),
        '/supplierLogin_screen': (context) => const SupplierLoginScreen(),
        '/supplierSignup_screen': (context) => const SupplierRegisterScreen(),
      },
    );
  }
}

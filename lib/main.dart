import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/main_Screens/customer_home.dart';
import 'package:multi_store_app/main_Screens/supplier_home.dart';
import 'package:multi_store_app/main_Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
      },
    );
  }
}

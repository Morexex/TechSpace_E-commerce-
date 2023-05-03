import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/main_Screens/category.dart';
import 'package:multi_store_app/main_Screens/dashboard.dart';
import 'package:multi_store_app/main_Screens/home.dart';
import 'package:multi_store_app/main_Screens/stores.dart';
import 'package:multi_store_app/main_Screens/upload_product.dart';
import 'package:badges/badges.dart' as badges;

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    DashBoardScreen(),
    UploadProductScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('deliverystatus', isEqualTo: 'preparing')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            body: _tabs[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedItemColor: Colors.purple,
              currentIndex: _selectedIndex,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Category',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.shop),
                  label: 'Stores',
                ),
                BottomNavigationBarItem(
                  icon: badges.Badge(
                      showBadge: snapshot.data!.docs.isEmpty ? false : true,
                      badgeStyle:
                          const badges.BadgeStyle(badgeColor: Colors.purple),
                      badgeContent: Text(
                        snapshot.data!.docs.length.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      child: const Icon(Icons.dashboard)),
                  label: 'Dashboard',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/balance.dart';
import 'package:multi_store_app/dashboard_components/edit_business.dart';
import 'package:multi_store_app/dashboard_components/manage_products.dart';
import 'package:multi_store_app/dashboard_components/my_store.dart';
import 'package:multi_store_app/dashboard_components/supplier_orders.dart';
import 'package:multi_store_app/dashboard_components/supplier_statics.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

List<String> Label = [
  'My Store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics'
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pages = const [
  MyStoreScreen(),
  SupplierOrdersScreen(),
  BusinessProfileScreen(),
  ManageProductsScreen(),
  SupplierBalanceScreen(),
  SupplierStaticsScreen(),
];

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Dashboard',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/welcome_screen');
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.yellowAccent.shade200,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      color: Colors.purple,
                      size: 50,
                    ),
                    Text(
                      Label[index].toLowerCase(),
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.purple,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Acme'),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

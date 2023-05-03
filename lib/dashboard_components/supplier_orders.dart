import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/preparing_orders.dart';
import 'package:multi_store_app/dashboard_components/transporting_orders.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

import 'delivered_orders.dart';

class SupplierOrdersScreen extends StatelessWidget {
  const SupplierOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: const AppBarTitle(
            title: 'Orders',
          ),
          bottom: const TabBar(
            indicatorColor: Colors.purple,
            indicatorWeight: 8,
            tabs: [
            RepeatedTab(label: 'Preparing'),
            RepeatedTab(label: 'Transporting'),
            RepeatedTab(label: 'Delivered'),
          ]),
        ),
        body: const TabBarView(children: [
          Preparing(),
          Transporting(),
          Delivered(),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screens/search_screen.dart';

import '../widgets/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.purple,
              indicatorWeight: 8,
              tabs: [
                RepeatedTab(label: 'Men'),
                RepeatedTab(label: 'Woman'),
                RepeatedTab(label: 'Bags'),
                RepeatedTab(label: 'Electronics'),
                RepeatedTab(label: 'Accessories'),
                RepeatedTab(label: 'Home & Garden'),
                RepeatedTab(label: 'Kids'),
                RepeatedTab(label: 'Beauty'),
              ]),
        ),
        body: const TabBarView(children: [
          Center(child: Text('Men Screen')),
          Center(child: Text('Women Screen')),
          Center(child: Text('Bags Screen')),
          Center(child: Text('Electonic Screen')),
          Center(child: Text('Accessories Screen')),
          Center(child: Text('Home & Garden Screen')),
          Center(child: Text('Kids Screen')),
          Center(child: Text('Beauty Screen')),
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
      child: Text(
        label,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

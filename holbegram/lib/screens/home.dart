import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BottomNav(),
    );
  }
}

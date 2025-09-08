import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String homeRoute = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Strings.home, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

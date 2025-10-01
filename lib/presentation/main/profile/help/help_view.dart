import 'package:flutter/material.dart';

class HelpView extends StatefulWidget {
  static const String routeName = '/help';
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Help')));
  }
}

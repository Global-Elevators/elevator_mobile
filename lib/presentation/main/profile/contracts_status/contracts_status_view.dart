import 'package:flutter/material.dart';

class ContractsStatusView extends StatefulWidget {
  static const String routeName = '/contracts-status';
  const ContractsStatusView({super.key});

  @override
  State<ContractsStatusView> createState() => _ContractsStatusViewState();
}

class _ContractsStatusViewState extends State<ContractsStatusView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Contracts Status')));
  }
}

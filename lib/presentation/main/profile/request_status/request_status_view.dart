import 'package:flutter/material.dart';

class RequestStatusView extends StatefulWidget {
  static const String routeName = '/request-status';
  const RequestStatusView({super.key});

  @override
  State<RequestStatusView> createState() => _RequestStatusViewState();
}

class _RequestStatusViewState extends State<RequestStatusView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Request Status')));
  }
}

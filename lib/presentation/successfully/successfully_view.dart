import 'package:flutter/material.dart';

class SuccessfullyView extends StatelessWidget {
  const SuccessfullyView({super.key});
  static const String successfullyRoute = '/successfully';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Successfully View"),
      ),
    );
  }
}

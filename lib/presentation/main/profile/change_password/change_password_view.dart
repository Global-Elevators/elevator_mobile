import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  static const String routeName = '/change-password';
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Change Password')));
  }
}

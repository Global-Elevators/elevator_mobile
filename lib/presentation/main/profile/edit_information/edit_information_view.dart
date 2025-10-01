import 'package:flutter/material.dart';

class EditInformationView extends StatefulWidget {
  static const String routeName = '/edit-information';
  const EditInformationView({super.key});

  @override
  State<EditInformationView> createState() => _EditInformationViewState();
}

class _EditInformationViewState extends State<EditInformationView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Edit Information')));
  }
}

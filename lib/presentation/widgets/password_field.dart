import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordField({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFromFieldWidget(
      hintText: Strings.passwordTitle,
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      prefixIcon: const Icon(Icons.lock_outline),
    );
  }
}

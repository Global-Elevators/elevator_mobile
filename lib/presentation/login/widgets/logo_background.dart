import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageAssets.background, fit: BoxFit.cover);
  }
}

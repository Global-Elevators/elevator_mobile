import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(ImageAssets.logo),
    );
  }
}

import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class OtpImage extends StatelessWidget {
  const OtpImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageAssets.message);
  }
}

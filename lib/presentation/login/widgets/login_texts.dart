import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.welcomeTitle,
      style: getBoldTextStyle(
        color: ColorManager.primaryColor,
        fontSize: 28.sp,
      ),
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.welcomeMessage,
      style: getMediumTextStyle(
        color: ColorManager.greyColor,
        fontSize: 18.sp,
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  final String title;

  const InputLabel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getMediumTextStyle(
        color: ColorManager.primaryColor,
        fontSize: 18.sp,
      ),
    );
  }
}

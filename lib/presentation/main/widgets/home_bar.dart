import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.welcomeBack.tr(),
              style: getMediumTextStyle(
                color: ColorManager.orangeColor,
                fontSize: FontSizeManager.s18.sp,
              ),
            ),
            Text(
              Strings.userName.tr(),
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s22.sp,
              ),
            ),
          ],
        ),
        const Spacer(),
        BackButtonWidget(popOrGo: false),
      ],
    );
  }
}

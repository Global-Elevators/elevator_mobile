import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBar extends StatelessWidget {
  final String? userName;

  const HomeBar({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${Strings.welcomeBack.tr()} ${FlavorConfig.instance.name}",
              style: getMediumTextStyle(
                color: ColorManager.orangeColor,
                fontSize: FontSizeManager.s18.sp,
              ),
            ),
            Text(
              userName ?? "",
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

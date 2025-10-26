import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final Stream<bool>? emailValidationStream;

  const EmailField({
    super.key,
    required this.emailController,
    required this.emailValidationStream,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.emailLabel.tr(), isOptional: true),
        Gap(AppSize.s8.h),
        StreamBuilder<bool>(
          stream: emailValidationStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              TextFromFieldWidget(
                hintText: Strings.email.tr(),
                controller: emailController,
                prefixIcon: SvgPicture.asset(
                  IconAssets.email,
                  width: AppSize.s20,
                  height: AppSize.s20,
                  fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                    ColorManager.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
        ),
      ],
    );
  }
}

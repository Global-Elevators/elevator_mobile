import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Stream<bool>? passwordValidationStream;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.passwordValidationStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: passwordValidationStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
          TextFromFieldWidget(
            hintText: hintText,
            controller: controller,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            prefixIcon: SvgPicture.asset(
              IconAssets.passwordIconField,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                ColorManager.primaryColor,
                BlendMode.srcIn,
              ),
              width: 21,
              height: 21,
            ),
            errorText: (snapshot.data ?? true) ? null : Strings.invalidPassword.tr(),
          ),
    );
  }
}

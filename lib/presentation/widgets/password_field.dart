import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) => TextFromFieldWidget(
        hintText: hintText,
        controller: controller,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        prefixIcon: Image.asset(
          IconAssets.passwordIconField,
          color: ColorManager.primaryColor,
          width: AppSize.s5.w,
          height: AppSize.s5.h,
        ),
        errorText: (snapshot.data ?? true) ? null : Strings.invalidPassword,
      ),
    );
  }
}

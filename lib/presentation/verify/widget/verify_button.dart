import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyButton extends StatelessWidget {
  final Stream<bool>? isButtonEnabledStream;
  final void Function()? onTap;

  const VerifyButton(this.isButtonEnabledStream, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return InputButtonWidget(
      radius: AppSize.s14.r,
      text: Strings.verifyButton,
      onTap: onTap,
      isButtonEnabledStream: isButtonEnabledStream,
    );
  }
}

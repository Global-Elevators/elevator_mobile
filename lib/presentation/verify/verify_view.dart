import 'dart:async';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/verify/widget/number_label.dart';
import 'package:elevator/presentation/verify/widget/resend_code.dart';
import 'package:elevator/presentation/verify/widget/verify_button.dart';
import 'package:elevator/presentation/verify/widget/verify_image.dart';
import 'package:elevator/presentation/verify/widget/verify_input_field.dart';
import 'package:elevator/presentation/verify/widget/verify_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class VerifyView extends StatefulWidget {
  static const String verifyRoute = '/verify';
  // final String phone;
  final List<String> codes;
  const VerifyView({required this.codes, super.key});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  int _seconds = 30;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String firstThree = widget.codes[0].substring(0, 3);
    final String stars = 'X' * (widget.codes[0].length - 3);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s16.r),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerifyImage(),
              VerifyTitle(),
              Gap(AppSize.s8.h),
              NumberLabel(firstThree: firstThree, stars: stars),
              Gap(AppSize.s28.h),
              VerifyInputField(),
              Gap(AppSize.s40.h),
              VerifyButton(widget.codes[1]),
              Gap(AppSize.s25.h),
              ResendCode(seconds: _seconds),
            ],
          ),
        ),
      ),
    );
  }
}

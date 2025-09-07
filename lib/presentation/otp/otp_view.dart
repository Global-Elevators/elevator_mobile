import 'dart:async';
import 'package:elevator/presentation/otp/widget/number_label.dart';
import 'package:elevator/presentation/otp/widget/otp_image.dart';
import 'package:elevator/presentation/otp/widget/otp_input_field.dart';
import 'package:elevator/presentation/otp/widget/resend_code.dart';
import 'package:elevator/presentation/otp/widget/verify_button.dart';
import 'package:elevator/presentation/otp/widget/verify_title.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OtpView extends StatefulWidget {
  static const String otpRoute = '/otp';
  final String phone;

  const OtpView(this.phone, {super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
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
    final String firstThree = widget.phone.substring(0, 3);
    final String stars = 'X' * (widget.phone.length - 3);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s16.r),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OtpImage(),
              VerifyTitle(),
              Gap(AppSize.s8.h),
              NumberLabel(firstThree: firstThree, stars: stars),
              Gap(AppSize.s28.h),
              OtpInputField(),
              Gap(AppSize.s40.h),
              VerifyButton(),
              Gap(AppSize.s25.h),
              ResendCode(seconds: _seconds),
            ],
          ),
        ),
      ),
    );
  }
}

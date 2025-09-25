import 'dart:async';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/account_verified/account_verified_view.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/new_password/new_password_view.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/verify/verify_viewmodel.dart';
import 'package:elevator/presentation/verify/widget/number_label.dart';
import 'package:elevator/presentation/verify/widget/resend_code.dart';
import 'package:elevator/presentation/verify/widget/verify_button.dart';
import 'package:elevator/presentation/verify/widget/verify_image.dart';
import 'package:elevator/presentation/verify/widget/verify_input_field.dart';
import 'package:elevator/presentation/verify/widget/verify_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/scheduler.dart';

class VerifyView extends StatefulWidget {
  static const String verifyRoute = '/verify';
  final List<String> codes;

  const VerifyView({required this.codes, super.key});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  late final Timer _timer;
  final _viewModel = instance<VerifyViewModel>();
  final ValueNotifier<int> _secondsNotifier = ValueNotifier<int>(30);

  @override
  void initState() {
    super.initState();
    _startTimer();
    _viewModel.start();
    _viewModel.setPhone(widget.codes[0]);
    isVerifyCorrect();
  }

  void isVerifyCorrect() {
    _viewModel.isUserEnterVerifyCodeSuccessfullyController.stream.listen((
      isVerifyCorrect,
    ) {
      if (isVerifyCorrect) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (widget.codes[1] == "login") {
            context.go(
              AccountVerifiedView.accountVerifiedRoute,
              extra: widget.codes[1],
            );
          }else{
            context.go(
              NewPasswordView.newPasswordRoute,
              extra: _viewModel.token,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _secondsNotifier.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsNotifier.value > 0) {
        _secondsNotifier.value = _secondsNotifier.value - 1;
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
      backgroundColor: Colors.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputStateStream,
        builder: (context, snapshot) {
          return snapshot.data?.getStateWidget(
                context,
                _getContentWidget(firstThree, stars),
                () {},
              ) ??
              _getContentWidget(firstThree, stars);
        },
      ),
    );
  }

  Padding _getContentWidget(String firstThree, String stars) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s16.r),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            VerifyImage(),
            VerifyTitle(),
            Gap(AppSize.s8.h),
            NumberLabel(firstThree: firstThree, stars: stars),
            Gap(AppSize.s28.h),
            VerifyInputField((value) {
              _viewModel.setCode(value);
              _viewModel.inputAreAllInputsValid.add(true);
            }),
            Gap(AppSize.s40.h),
            VerifyButton(_viewModel.areAllInputsValid, () {
              if (widget.codes[1] == "login") {
                _viewModel.verify();
              } else {
                _viewModel.verifyForgotPassword();
              }
            }),
            Gap(AppSize.s25.h),
            ValueListenableBuilder<int>(
              valueListenable: _secondsNotifier,
              builder: (context, seconds, _) {
                return ResendCode(
                  seconds: seconds,
                  onTap: () => seconds > 0 ? null : debugPrint("Moamen"),
                );
              },
            ),
            Gap(AppSize.s22.h),
          ],
        ),
      ),
    );
  }
}

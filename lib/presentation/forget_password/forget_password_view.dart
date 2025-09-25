import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/forget_password/forget_password_viewmodel.dart';
import 'package:elevator/presentation/forget_password/widgets/forget_password_appbar.dart';
import 'package:elevator/presentation/forget_password/widgets/forget_password_body.dart';
import 'package:elevator/presentation/verify/verify_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';


class ForgetPasswordView extends StatefulWidget {
  static const String forgetPasswordRoute = '/forget-password';

  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _phoneController = TextEditingController();

  final _forgetPasswordViewmodel = instance<ForgetPasswordViewmodel>();

  @override
  void initState() {
    super.initState();
    _forgetPasswordViewmodel.start();
    _phoneController.addListener(() {
      _forgetPasswordViewmodel.setUserPhone(_phoneController.text);
    });
    isUserEnterCorrectNumber();
  }

  void isUserEnterCorrectNumber() {
    _forgetPasswordViewmodel.didTheUserEnterTheCorrectPhoneNumber.stream.listen((didUserEnterTheCorrectPhoneNumber) {
      if (didUserEnterTheCorrectPhoneNumber) {
        SchedulerBinding.instance.addPostFrameCallback((_){
          context.go(
            VerifyView.verifyRoute,
            extra: [_phoneController.text, "forget-password"],
          );
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ForgetPasswordAppBar(),
      body: StreamBuilder<FlowState>(
        stream: _forgetPasswordViewmodel.outputStateStream,
        builder: (BuildContext context, snapshot) =>
            snapshot.data?.getStateWidget(
              context,
              ForgetPasswordBody(
                phoneController: _phoneController,
                onGetCode: () {
                  _forgetPasswordViewmodel.sendVerificationCode();
                },
                isButtonEnabledStream: _forgetPasswordViewmodel.outIsPhoneValid,
              ),
              () {},
            ) ??
            ForgetPasswordBody(
              phoneController: _phoneController,
              onGetCode: () {
                _forgetPasswordViewmodel.sendVerificationCode();
              },
              isButtonEnabledStream: _forgetPasswordViewmodel.outIsPhoneValid,
            ),
      ),
    );
  }
}

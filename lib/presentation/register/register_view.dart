import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/network_aware_widget.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/register/register_viewmodel.dart';
import 'package:elevator/presentation/register/widgets/interest_item.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/back_to_button.dart';
import 'package:elevator/presentation/widgets/build_date_of_birth_section_widget.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/email_field.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/items_drop_down.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/password_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  static const String registerRoute = '/register';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _firstNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _grandFatherNameController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  int _selectedInterest = 0;
  final _interests = [
    Strings.newProduct.tr(),
    Strings.preventiveMaintenance.tr(),
    Strings.repair.tr(),
    Strings.consultancy.tr(),
    Strings.jointVenture.tr(),
  ];
  DateTime selectedDate = DateTime.now();

  String? selectedAddress;
  final List<String> addresses = ["Cairo", "Alexandria", "Giza", "Mansoura"];
  final String hintText = Strings.selectYourAddress.tr();

  final _registerViewModel = instance<RegisterViewModel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _bind() {
    _registerViewModel.start();
    final now = DateTime.now();
    _dayController.text = now.day.toString();
    _monthController.text = now.month.toString();
    _yearController.text = now.year.toString();
    updatingPhoneAndPasswordValues();
    isRegisterSuccessfully();
  }

  void updatingPhoneAndPasswordValues() {
    _phoneController.addListener(
      () => _registerViewModel.setPhoneNumber(_phoneController.text),
    );

    _firstNameController.addListener(
      () => _registerViewModel.setName(_firstNameController.text),
    );

    _grandFatherNameController.addListener(
      () => _registerViewModel.setGrandFatherName(
        _grandFatherNameController.text,
      ),
    );

    _fatherNameController.addListener(
      () => _registerViewModel.setFatherName(_fatherNameController.text),
    );

    _passwordController.addListener(
      () => _registerViewModel.setPassword(_passwordController.text),
    );

    _phoneController.addListener(
      () => _registerViewModel.setPhoneNumber(_phoneController.text),
    );
    _confirmPasswordController.addListener(
      () => _registerViewModel.setConfirmPassword(
        _confirmPasswordController.text,
      ),
    );

    _emailController.addListener(
      () => _registerViewModel.setEmail(_emailController.text),
    );
  }

  void isRegisterSuccessfully() {
    _registerViewModel.isUserRegisteredSuccessfullyController.stream.listen((
      isUserRegisteredSuccessfully,
    ) {
      if (isUserRegisteredSuccessfully) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) => context.go(LoginView.loginRoute),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _registerViewModel.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _fatherNameController.dispose();
    _grandFatherNameController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      onlineChild: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<FlowState>(
          stream: _registerViewModel.outputStateStream,
          builder: (context, snapshot) =>
              snapshot.data?.getStateWidget(
                context,
                _getContentWidget(),
                () {},
              ) ??
              _getContentWidget(),
        ),
      ),
    );
  }

  SingleChildScrollView _getContentWidget() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(),
              Gap(AppSize.s12.h),
              _buildHeader(),
              Gap(AppSize.s22.h),
              BuildNameSection(
                firstNameController: _firstNameController,
                fatherNameController: _fatherNameController,
                grandFatherNameController: _grandFatherNameController,
                fatherNameStream: _registerViewModel.outIsFatherNameValid,
                grandFatherNameStream:
                    _registerViewModel.outIsGrandFatherNameValid,
                nameStream: _registerViewModel.outIsNameValid,
              ),
              BuildDateOfBirthSectionWidget(
                dayController: _dayController,
                monthController: _monthController,
                yearController: _yearController,
                onDateSelected: (date) {
                  String parsedDate = "${date.year}-${date.month}-${date.day}";
                  _registerViewModel.setBirthDate(parsedDate);
                  setState(() {
                    _dayController.text = date.day.toString();
                    _monthController.text = date.month.toString();
                    _yearController.text = date.year.toString();
                  });
                  log(parsedDate);
                },
              ),
              _buildContactSection(),
              Gap(AppSize.s25.h),
              _buildPasswordSection(),
              _buildInterestsSection(),
              Gap(AppSize.s25.h),
              _buildSignUpButton(),
              Gap(AppSize.s10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() => BackToSignInButton(route: LoginView.loginRoute);

  Widget _buildHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        Strings.createAccountTitle.tr(),
        style: getBoldTextStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s28,
        ),
      ),
      Text(
        Strings.createAccountMessage.tr(),
        style: getMediumTextStyle(
          color: ColorManager.greyColor,
          fontSize: FontSizeManager.s18,
        ),
      ),
    ],
  );

  Widget _buildContactSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelField(Strings.phoneNumberTitle.tr()),
      Gap(AppSize.s8.h),
      PhoneField(
        controller: _phoneController,
        phoneValidationStream: _registerViewModel.outIsPhoneNumberValid,
      ),
      Gap(AppSize.s25.h),
      EmailField(
        emailController: _emailController,
        emailValidationStream: _registerViewModel.outIsEmailValid,
      ),
      LabelField(Strings.addressLabel.tr()),
      Gap(AppSize.s8.h),
      ItemsDropDown(
        items: addresses,
        hintText: hintText,
        selectedItem: selectedAddress,
        onChanged: (value) {
          setState(() {
            selectedAddress = value;
          });
          _registerViewModel.setAddress(selectedAddress!);
        },
      ),
    ],
  );

  Widget _buildPasswordSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelField(Strings.passwordTitle.tr()),
      Gap(AppSize.s8.h),
      PasswordField(
        controller: _passwordController,
        hintText: Strings.passwordTitle.tr(),
        passwordValidationStream: _registerViewModel.outIsPasswordValid,
      ),
      PasswordField(
        controller: _confirmPasswordController,
        hintText: Strings.confirmPassword.tr(),
        passwordValidationStream: _registerViewModel.outIsConfirmPasswordValid,
      ),
    ],
  );

  Widget _buildInterestsSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelField(Strings.interestsLabel.tr(), isOptional: true),
      Gap(AppSize.s8.h),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _interests.length,
        itemBuilder: (context, index) => InterestItem(
          text: _interests[index],
          isSelected: _selectedInterest == index,
          onTap: () => setState(() => _selectedInterest = index),
        ),
        separatorBuilder: (_, __) => Gap(AppSize.s8.h),
      ),
    ],
  );

  Widget _buildSignUpButton() => InputButtonWidget(
    radius: AppSize.s14,
    text: Strings.signUpButton.tr(),
    onTap: () => _registerViewModel.register(),
    isButtonEnabledStream: _registerViewModel.areAllInputsValidStream,
  );
}

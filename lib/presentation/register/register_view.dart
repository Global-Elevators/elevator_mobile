import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/widgets/items_drop_down.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/widgets/back_to_button.dart';
import 'package:elevator/presentation/register/widgets/date_of_birth_row.dart';
import 'package:elevator/presentation/register/widgets/interest_item.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/password_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../verify/verify_view.dart';

enum DateOfBirthType { Day, Month, Year }

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
    Strings.newProduct,
    Strings.preventiveMaintenance,
    Strings.repair,
    Strings.consultancy,
    Strings.jointVenture,
  ];

  String? selectedAddress;
  final List<String> addresses = ["Cairo", "Alexandria", "Giza", "Mansoura"];
  final String hintText = "Select your address";

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dayController.text = now.day.toString();
    _monthController.text = now.month.toString();
    _yearController.text = now.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                ),
                Gap(AppSize.s25.h),
                _buildDateOfBirthSection(),
                Gap(AppSize.s25.h),
                _buildContactSection(),
                Gap(AppSize.s25.h),
                _buildPasswordSection(),
                Gap(AppSize.s25.h),
                _buildInterestsSection(),
                Gap(AppSize.s25.h),
                _buildSignUpButton(),
                Gap(AppSize.s10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() =>
      BackToSignInButton(text: Strings.backSignIn, route: LoginView.loginRoute);

  Widget _buildHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        Strings.createAccountTitle,
        style: getBoldTextStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s28,
        ),
      ),
      Text(
        Strings.createAccountMessage,
        style: getMediumTextStyle(
          color: ColorManager.greyColor,
          fontSize: FontSizeManager.s18,
        ),
      ),
    ],
  );

  Widget _buildDateOfBirthSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const LabelField(Strings.dateOfBirth),
      Gap(AppSize.s14.h),
      Row(
        children: DateOfBirthType.values.map((type) {
          return Expanded(
            child: Text(
              type.name,
              style: getMediumTextStyle(
                color: ColorManager.greyColor,
                fontSize: FontSizeManager.s18.sp,
              ),
            ),
          );
        }).toList(),
      ),
      DateOfBirthRow(
        dayController: _dayController,
        monthController: _monthController,
        yearController: _yearController,
        onDateSelected: (date) {
          setState(() {
            _dayController.text = date.day.toString();
            _monthController.text = date.month.toString();
            _yearController.text = date.year.toString();
          });
        },
      ),
    ],
  );

  Widget _buildContactSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const LabelField(Strings.phoneNumberTitle),
      Gap(AppSize.s8.h),
      PhoneField(controller: _phoneController, phoneValidationStream: null),
      Gap(AppSize.s25.h),
      LabelField(Strings.emailLabel, isOptional: true),
      Gap(AppSize.s8.h),
      TextFromFieldWidget(
        hintText: Strings.email,
        controller: _emailController,
        prefixIcon: Image.asset(
          IconAssets.email,
          width: AppSize.s20,
          height: AppSize.s20,
          color: ColorManager.primaryColor,
        ),
      ),
      Gap(AppSize.s25.h),
      const LabelField(Strings.addressLabel),
      Gap(AppSize.s8.h),
      ItemsDropDown(
        items: addresses,
        hintText: hintText,
        selectedItem: selectedAddress,
        onChanged: (value) {
          setState(() {
            selectedAddress = value;
          });
        },
      ),
    ],
  );

  Widget _buildPasswordSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const LabelField(Strings.passwordTitle),
      Gap(AppSize.s8.h),
      PasswordField(
        controller: _passwordController,
        hintText: Strings.passwordTitle,
        passwordValidationStream: null,
      ),
      Gap(AppSize.s8.h),
      PasswordField(
        controller: _confirmPasswordController,
        hintText: Strings.confirmPassword,
        passwordValidationStream: null,
      ),
    ],
  );

  Widget _buildInterestsSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const LabelField(Strings.interestsLabel, isOptional: true),
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
    text: Strings.signUpButton,
    onTap: () => context.push(
      LoginView.loginRoute,
    ),
  );
}

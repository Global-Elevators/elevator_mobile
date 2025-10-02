import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/build_date_of_birth_section_widget.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:elevator/presentation/widgets/custom_bottom_sheet.dart';
import 'package:elevator/presentation/widgets/email_field.dart';
import 'package:elevator/presentation/widgets/items_drop_down.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class EditInformationView extends StatefulWidget {
  static const String routeName = '/edit-information';

  const EditInformationView({super.key});

  @override
  State<EditInformationView> createState() => _EditInformationViewState();
}

class _EditInformationViewState extends State<EditInformationView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _grandFatherNameController =
      TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final List<String> _addresses = ['Cairo', 'Alexandria', 'Mansoura'];
  String? _selectedAddress;
  final String _addressHint = "Select your address";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Strings.editInformation,
        showBackButton: true,
        popOrGo: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _requestPendingReviewSection(),
              Gap(AppSize.s20.h),
              _buildNameSection(),
              Gap(AppSize.s20.h),
              _buildDateOfBirthSection(),
              Gap(AppSize.s20.h),
              _buildPhoneSection(),
              Gap(AppSize.s20.h),
              _buildEmailSection(),
              Gap(AppSize.s20.h),
              _buildAddressSection(),
              Gap(AppSize.s20.h),
              _buildApplyButton(),
              Gap(AppSize.s16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _requestPendingReviewSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.p16.h,
        horizontal: AppPadding.p16.w,
      ),
      decoration: BoxDecoration(
        color: Color(0xffFFF5E9),
        borderRadius: BorderRadius.circular(AppSize.s12.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            IconAssets.warning,
            height: AppSize.s22.h,
            width: AppSize.s22.w,
            colorFilter: ColorFilter.mode(
              Color(0xffFF9408),
              BlendMode.srcIn,
            ),
          ),
          Gap(AppSize.s16.w),
          Text(Strings.profileEditsAreBeingReviewed),
        ],
      ),
    );
  }

  Widget _buildNameSection() {
    return BuildNameSection(
      firstNameController: _firstNameController,
      fatherNameController: _fatherNameController,
      grandFatherNameController: _grandFatherNameController,
      nameStream: null,
      fatherNameStream: null,
      grandFatherNameStream: null,
    );
  }

  Widget _buildDateOfBirthSection() {
    return BuildDateOfBirthSectionWidget(
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
    );
  }

  Widget _buildPhoneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.phoneNumberTitle),
        Gap(AppSize.s8.h),
        PhoneField(controller: _phoneController, phoneValidationStream: null),
      ],
    );
  }

  Widget _buildEmailSection() {
    return EmailField(
      emailValidationStream: null,
      emailController: _emailController,
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelField(Strings.addressLabel),
        Gap(AppSize.s8.h),
        ItemsDropDown(
          items: _addresses,
          hintText: _addressHint,
          selectedItem: _selectedAddress,
          onChanged: (value) => setState(() => _selectedAddress = value),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return ButtonWidget(
      radius: AppSize.s14.r,
      text: Strings.apply,
      onTap: () {
        CustomBottomSheet.show(
          context: context,
          message: Strings.profileInformationRequestSent,
          buttonText: Strings.done,
          imagePath: ImageAssets.successfully,
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/main/profile/edit_information/edit_information_viewmodel.dart';
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
import 'dart:async';

class EditInformationView extends StatefulWidget {
  static const String routeName = '/edit-information';

  const EditInformationView({super.key});

  @override
  State<EditInformationView> createState() => _EditInformationViewState();
}

class _EditInformationViewState extends State<EditInformationView> {
  // --- Controllers ---
  final _firstNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _grandFatherNameController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  // --- Local data ---
  final List<String> _addresses = ['Cairo', 'Alexandria', 'Mansoura'];
  String? _selectedAddress;
  final String _addressHint = "Select your address";

  // --- ViewModel & Subscription ---
  final _viewmodel = instance<EditInformationViewModel>();
  StreamSubscription<FlowState>? _stateSubscription;

  @override
  void initState() {
    super.initState();
    _viewmodel.start();

    _stateSubscription = _viewmodel.outputStateStream.listen(_handleState);
  }

  void _handleState(FlowState state) {
    if (state is LoadingState || state is ErrorState) return;

    final user = _viewmodel.userDataModel?.user;
    if (user == null) return;

    _firstNameController.text = user.name;
    _fatherNameController.text = user.profile?.sirName ?? '';
    _grandFatherNameController.text = user.profile?.lastName ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = user.phone;

    DateTime? parsedDate;

    parsedDate = DateTime.parse(user.birthdate);

    _dayController.text = parsedDate.day.toString();
    _monthController.text = parsedDate.month.toString();
    _yearController.text = parsedDate.year.toString();
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();

    _firstNameController.dispose();
    _fatherNameController.dispose();
    _grandFatherNameController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _phoneController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Strings.editInformation.tr(),
        showBackButton: true,
        popOrGo: true,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewmodel.outputStateStream,
        initialData: LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
        builder: (context, snapshot) {
          final state = snapshot.data;
          return state?.getStateWidget(context, _buildContent(), () {}) ??
              _buildContent();
        },
      ),
    );
  }

  SafeArea _buildContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPendingReviewSection(),
            Gap(AppSize.s20.h),
            _buildNameSection(),
            _buildDateOfBirthSection(),
            _buildPhoneSection(),
            _buildEmailSection(),
            _buildAddressSection(),
            Gap(AppSize.s20.h),
            _buildApplyButton(),
            Gap(AppSize.s16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingReviewSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.p16.h,
        horizontal: AppPadding.p16.w,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFFF5E9),
        borderRadius: BorderRadius.circular(AppSize.s12.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            IconAssets.warning,
            height: AppSize.s22.h,
            width: AppSize.s22.w,
            colorFilter: const ColorFilter.mode(
              Color(0xffFF9408),
              BlendMode.srcIn,
            ),
          ),
          Gap(AppSize.s16.w),
          Text(Strings.profileEditsAreBeingReviewed.tr()),
        ],
      ),
    );
  }

  Widget _buildNameSection() => BuildNameSection(
    firstNameController: _firstNameController,
    fatherNameController: _fatherNameController,
    grandFatherNameController: _grandFatherNameController,
    nameStream: null,
    fatherNameStream: null,
    grandFatherNameStream: null,
  );

  Widget _buildDateOfBirthSection() => BuildDateOfBirthSectionWidget(
    dayController: _dayController,
    monthController: _monthController,
    yearController: _yearController,
    onDateSelected: (date) {
      _dayController.text = date.day.toString();
      _monthController.text = date.month.toString();
      _yearController.text = date.year.toString();
    },
  );

  Widget _buildPhoneSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelField(Strings.phoneNumberTitle.tr()),
      Gap(AppSize.s8.h),
      PhoneField(controller: _phoneController, phoneValidationStream: null),
    ],
  );

  Widget _buildEmailSection() => EmailField(
    emailController: _emailController,
    emailValidationStream: null,
  );

  Widget _buildAddressSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelField(Strings.addressLabel.tr()),
      Gap(AppSize.s8.h),
      ItemsDropDown(
        items: _addresses,
        hintText: _addressHint,
        selectedItem: _selectedAddress,
        onChanged: (value) => setState(() => _selectedAddress = value),
      ),
    ],
  );

  Widget _buildApplyButton() => ButtonWidget(
    radius: AppSize.s14.r,
    text: Strings.apply.tr(),
    onTap: () {
      CustomBottomSheet.show(
        context: context,
        message: Strings.profileInformationRequestSent.tr(),
        buttonText: Strings.done.tr(),
        imagePath: ImageAssets.successfully,
      );
    },
  );
}

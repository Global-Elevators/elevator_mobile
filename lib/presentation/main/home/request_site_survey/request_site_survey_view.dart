import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/request_site_survey/request_site_survey_viewmodel.dart';
import 'package:elevator/presentation/main/home/widgets/label_yes_or_no_widget.dart';
import 'package:elevator/presentation/main/home/widgets/scope_of_work.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/app_bar_label.dart';
import 'package:elevator/presentation/widgets/back_button.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/drop_down_scope.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class RequestSiteSurvey extends StatefulWidget {
  static const String requestSiteSurveyRoute = '/requestSiteSurvey';

  const RequestSiteSurvey({super.key});

  @override
  State<RequestSiteSurvey> createState() => _RequestSiteSurveyState();
}

class _RequestSiteSurveyState extends State<RequestSiteSurvey> {
  bool isProjectBelongsToSameAccount = false;
  final viewmodel = instance<RequestSiteSurveyViewmodel>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _grandFatherNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String? selectedValue;

  List<DropdownItem<String>> items = [
    DropdownItem(value: Strings.newProduct.tr()),
    DropdownItem(value: Strings.annualPreventiveMaintenance.tr()),
    DropdownItem(value: Strings.repair.tr()),
  ];

  late final DropdownController<String> _singleSelectionController;

  @override
  void initState() {
    super.initState();
    viewmodel.start();
    _singleSelectionController = DropdownController<String>.single(
      items: items,
    );
    updatingPhoneAndNamesValues();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _fatherNameController.dispose();
    _grandFatherNameController.dispose();
    _phoneNumberController.dispose();
    _singleSelectionController.dispose();
  }

  void updatingPhoneAndNamesValues() {
    _phoneNumberController.addListener(
      () => viewmodel.setPhoneNumber(_phoneNumberController.text),
    );
    _firstNameController.addListener(
      () => viewmodel.setName(_firstNameController.text),
    );
    _fatherNameController.addListener(
      () => viewmodel.setSirName(_fatherNameController.text),
    );
    _grandFatherNameController.addListener(
      () => viewmodel.setMiddleName(_grandFatherNameController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: AppSize.s70.h,
        width: AppSize.s70.w,
        child: selectedValue == null
            ? FloatingActionButton(
                onPressed: () => viewmodel.submitSiteSurvey(),
                backgroundColor: ColorManager.primaryColor,
                shape: const CircleBorder(),
                child: SvgPicture.asset(
                  IconAssets.call,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: AppSize.s28.w,
                  height: AppSize.s28.h,
                ),
              )
            : null,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: AppBarLabel(Strings.requestSiteSurvey.tr()),
        actions: [BackButtonWidget(popOrGo: true), Gap(AppSize.s16.w)],
      ),
      body: StreamBuilder<FlowState>(
        stream: viewmodel.outputStateStream,
        builder: (context, snapshot) {
          return snapshot.data?.getStateWidget(
                context,
                _getContentWidget(),
                () {},
              ) ??
              _getContentWidget();
        },
      ),
    );
  }

  SingleChildScrollView _getContentWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppSize.s16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelYesOrNoWidget(
              title: Strings.doesProjectBelongToSameAccount.tr(),
              condition: isProjectBelongsToSameAccount,
              onYesTap: () => setState(() {
                isProjectBelongsToSameAccount = false;
              }),
              onNoTap: () => setState(() {
                isProjectBelongsToSameAccount = true;
              }),
            ),
            Gap(AppSize.s25.h),
            BuildNameSection(
              firstNameController: _firstNameController,
              fatherNameController: _fatherNameController,
              grandFatherNameController: _grandFatherNameController,
              nameStream: viewmodel.outIsNameValid,
              fatherNameStream: viewmodel.outIsSirNameValid,
              grandFatherNameStream: viewmodel.outIsMiddleNameValid,
            ),
            LabelField(Strings.phoneNumberWhatsapp.tr()),
            PhoneField(
              controller: _phoneNumberController,
              phoneValidationStream: viewmodel.outIsPhoneNumberValid,
            ),
            Gap(AppSize.s10.h),
            LabelField(Strings.scopeOfWork.tr()),
            DropdownScope(
              controller: _singleSelectionController,
              selectedValue: selectedValue,
              onChangedItem: (value) {
                setState(() => selectedValue = value);
              },
            ),
            Gap(AppSize.s18.h),
            Visibility(
              visible: selectedValue != null,
              child: Builder(
                builder: (context) {
                  DropdownItem<String> selectedItem = items.firstWhere(
                    (item) => item.value == selectedValue,
                    orElse: () => DropdownItem(value: ""),
                  );
                  return ScopeOfWork(selectedItem.value, viewmodel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:elevator/presentation/main/home/widgets/label_yes_or_no_widget.dart';
import 'package:elevator/presentation/main/home/widgets/scope_of_work.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/back_button.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/drop_down_scope.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RequestSiteSurvey extends StatefulWidget {
  static const String requestSiteSurveyRoute = '/requestSiteSurvey';

  const RequestSiteSurvey({super.key});

  @override
  State<RequestSiteSurvey> createState() => _RequestSiteSurveyState();
}

class _RequestSiteSurveyState extends State<RequestSiteSurvey> {
  bool isProjectBelongsToSameAccount = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _grandFatherNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String? selectedValue;

  List<DropdownItem<String>> items = [
    DropdownItem(value: Strings.newProduct),
    DropdownItem(value: Strings.annualPreventiveMaintenance),
    DropdownItem(value: Strings.repair),
  ];

  late final DropdownController<String> _singleSelectionController;

  @override
  void initState() {
    super.initState();
    _singleSelectionController = DropdownController<String>.single(
      items: items,
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          Strings.requestSiteSurvey,
          style: getBoldTextStyle(
            color: ColorManager.primaryColor,
            fontSize: FontSizeManager.s28,
          ),
        ),
        actions: [BackButtonWidget(popOrGo: true), Gap(AppSize.s16.w)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: AppSize.s16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelYesOrNoWidget(
                title: Strings.doesProjectBelongToSameAccount,
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
                nameStream: null,
                fatherNameStream: null,
                grandFatherNameStream: null,
              ),
              Gap(AppSize.s25.h),
              LabelField(Strings.phoneNumberWhatsapp),
              PhoneField(
                controller: _phoneNumberController,
                phoneValidationStream: null,
              ),
              Gap(AppSize.s25.h),
              LabelField(Strings.scopeOfWork),
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
                    return ScopeOfWork(selectedItem.value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:elevator/presentation/main/widgets/yes_or_no_button.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/items_drop_down.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/optional_text.dart';
import 'package:elevator/presentation/widgets/table_calendar_widget.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ScopeOfWork extends StatefulWidget {
  final String name;

  const ScopeOfWork(this.name, {super.key});

  @override
  State<ScopeOfWork> createState() => _ScopeOfWorkState();
}

class _ScopeOfWorkState extends State<ScopeOfWork> {
  final TextEditingController _projectTypeController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();
  final TextEditingController _pitDepthCmController = TextEditingController();
  final TextEditingController _lastFloorHeightCmController =
      TextEditingController();
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _stopsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final List<String> projectTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];

  final List<String> shaftLocationItems = ["Cairo", "Alex", "Mansoura", "Giza"];

  final List<String> shaftDimensionsItems = [
    "Cairo",
    "Alex",
    "Mansoura",
    "Giza",
  ];

  String? selectedProjectType;
  String? selectedShaftLocation;
  String? selectedShaftDimensions;
  bool doesTheShaftHaveAMachineRoom = false;
  int _displayedNumber = 0;

  @override
  void initState() {
    super.initState();
    _stopsController.addListener(_updateDisplayedNumber);
  }

  void _updateDisplayedNumber() {
    setState(() {
      int number = int.parse(_stopsController.text);
      ++number;
      _displayedNumber = number;
    });
  }

  List<DateTime> disabledDays = [
    DateTime.utc(2025, 9, 15),
    DateTime.utc(2025, 9, 18),
    DateTime.utc(2025, 9, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.projectAddress),
        Gap(AppSize.s8.h),
        TextFromFieldWidget(
          hintText: Strings.manualOrSelect,
          controller: _projectTypeController,
        ),
        Gap(AppSize.s25.h),
        LabelField(Strings.projectType),
        Gap(AppSize.s8.h),
        buildItemsDropDown(projectTypeItems, selectedProjectType, (value) {
          setState(() {
            selectedProjectType = value;
          });
        }),
        Gap(AppSize.s25.h),
        OptionalText(Strings.shaftLocation),
        Gap(AppSize.s8.h),
        buildItemsDropDown(shaftLocationItems, selectedShaftLocation, (value) {
          setState(() {
            selectedShaftLocation = value;
          });
        }),
        Gap(AppSize.s25.h),
        OptionalText(Strings.shaftDimensions),
        Gap(AppSize.s8.h),
        theTwoFormFields(
          _widthController,
          _depthController,
          Strings.widthCm,
          Strings.depthCm,
        ),
        Gap(AppSize.s25.h),
        Row(
          children: [
            OptionalText(Strings.pitDepth),
            Spacer(),
            LabelField(Strings.lastFloorHeight),
          ],
        ),
        Gap(AppSize.s8.h),
        theTwoFormFields(
          _pitDepthCmController,
          _lastFloorHeightCmController,
          Strings.cm,
          Strings.cm,
        ),
        Gap(AppSize.s25.h),
        OptionalText(Strings.doesTheShaftHaveAMachineRoom),
        Gap(AppSize.s8.h),
        YesOrNoButton(
          condition: doesTheShaftHaveAMachineRoom,
          onYesTap: () {
            setState(() {
              doesTheShaftHaveAMachineRoom = false;
            });
          },
          onNoTap: () {
            setState(() {
              doesTheShaftHaveAMachineRoom = true;
            });
          },
        ),
        Gap(AppSize.s10.h),
        LabelField(Strings.height),
        Gap(AppSize.s8.h),
        TextFromFieldWidget(
          hintText: Strings.cm,
          controller: _cmController,
          centerText: false,
        ),
        Gap(AppSize.s25.h),
        OptionalText(Strings.howManyStops),
        Gap(AppSize.s8.h),
        Row(
          children: [
            Text(
              Strings.gPlus,
              style: getRegularTextStyle(
                color: ColorManager.greyColor,
                fontSize: FontSizeManager.s18.sp,
              ),
            ),
            Gap(AppSize.s5.w),
            Expanded(
              child: TextFromFieldWidget(
                hintText: Strings.x,
                controller: _stopsController,
                keyboardType: TextInputType.number,
                centerText: false,
              ),
            ),
            Gap(AppSize.s5.w),
            Text(
              _displayedNumber.toString(),
              style: getRegularTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s18.sp,
              ),
            ),
            Gap(AppSize.s5.w),
            Text(
              Strings.stops,
              style: getRegularTextStyle(
                color: ColorManager.greyColor,
                fontSize: FontSizeManager.s18.sp,
              ),
            ),
          ],
        ),
        Gap(AppSize.s25.h),
        LabelField(Strings.selectSuitableTimeToConductTheSiteSurvey),
        Gap(AppSize.s8.h),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s22.r),
            border: Border.all(color: ColorManager.formFieldsBorderColor),
          ),
          child: TableCalendarWidget(
            disabledDays: [],
            focusedDay: DateTime.now(),
          ),
        ),
        Gap(AppSize.s25.h),
        OptionalText(Strings.notes),
        Gap(AppSize.s8.h),
        TextFromFieldWidget(
          hintText: Strings.notes,
          controller: _notesController,
          centerText: false,
          isNotes: true,
        ),
      ],
    );
  }

  Row theTwoFormFields(
    firstController,
    secondController,
    firstText,
    secondText,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextFromFieldWidget(
            hintText: firstText,
            controller: firstController,
            keyboardType: TextInputType.number,
            centerText: false,
          ),
        ),
        Gap(AppSize.s8.w),
        Expanded(
          child: TextFromFieldWidget(
            hintText: secondText,
            controller: secondController,
            keyboardType: TextInputType.number,
            centerText: false,
          ),
        ),
      ],
    );
  }

  ItemsDropDown buildItemsDropDown(
    List<String> items,
    String? selectedItem,
    void Function(String?) onChanged,
  ) {
    return ItemsDropDown(
      items: items,
      hintText: Strings.selectOne,
      onChanged: onChanged,
      selectedItem: selectedItem,
    );
  }
}

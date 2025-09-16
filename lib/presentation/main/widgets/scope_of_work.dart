import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:elevator/presentation/main/widgets/yes_or_no_button.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:elevator/presentation/widgets/items_drop_down.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/table_calendar_widget.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ScopeOfWork extends StatefulWidget {
  final String name;

  const ScopeOfWork(this.name, {super.key});

  @override
  State<ScopeOfWork> createState() => _ScopeOfWorkState();
}

class _ScopeOfWorkState extends State<ScopeOfWork> {
  final TextEditingController _projectAddressController =
      TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();
  final TextEditingController _pitDepthCmController = TextEditingController();
  final TextEditingController _lastFloorHeightCmController =
      TextEditingController();
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _stopsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _elevatorBrandController =
      TextEditingController();
  final TextEditingController _descriptionOfBreakDownController =
      TextEditingController();

  final List<String> projectTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];

  final List<String> shaftTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];

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
  String? selectedShaftType;
  bool doesTheShaftHaveAMachineRoom = false;
  bool isTheElevatorUnderWarranty = false;
  int _displayedNumber = 0;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _stopsController.addListener(_updateDisplayedNumber);
  }

  void _updateDisplayedNumber() {
    setState(() {
      int number = int.parse(_stopsController.text);
      if (_stopsController.text.isNotEmpty) {
        ++number;
        _displayedNumber = number;
      }
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
        labelTextFormFieldWidget(
          Strings.projectAddress,
          Strings.projectAddress,
          _projectAddressController,
        ),
        Gap(AppSize.s25.h),
        labelDropDownWidget(
          Strings.projectType,
          projectTypeItems,
          selectedProjectType,
          (value) => setState(() => selectedProjectType = value),
        ),
        if (widget.name == Strings.newProduct) Gap(AppSize.s25.h),
        if (widget.name == Strings.annualPreventiveMaintenance ||
            widget.name == Strings.repair) ...[
          labelYesOrNoWidget(
            Strings.isTheElevatorUnderWarranty,
            isTheElevatorUnderWarranty,
            () => setState(() => isTheElevatorUnderWarranty = false),
            () => setState(() => isTheElevatorUnderWarranty = true),
          ),
          Gap(AppSize.s25.h),
          labelTextFormFieldWidget(
            Strings.elevatorBrand,
            Strings.elevatorBrand,
            _elevatorBrandController,
          ),
        ],
        if (widget.name == Strings.newProduct)
          labelDropDownWidget(
            Strings.shaftType,
            shaftTypeItems,
            selectedShaftType,
            (value) {
              setState(() {
                selectedShaftType = value;
              });
            },
          ),
        Gap(AppSize.s25.h),
        labelDropDownWidget(
          Strings.shaftLocation,
          shaftLocationItems,
          selectedShaftLocation,
          (value) {
            setState(() {
              selectedShaftLocation = value;
            });
          },
        ),
        if (widget.name == Strings.newProduct) shaftDimensionsWidget(),
        if (widget.name == Strings.newProduct)
          pitDepthAndLastFloorHeightWidget(),
        if (widget.name == Strings.newProduct)
          labelYesOrNoWidget(
            Strings.doesTheShaftHaveAMachineRoom,
            doesTheShaftHaveAMachineRoom,
            () => setState(() => doesTheShaftHaveAMachineRoom = false),
            () => setState(() => doesTheShaftHaveAMachineRoom = true),
          ),
        if (widget.name == Strings.newProduct)
          labelTextFormFieldWidget(
            Strings.height,
            Strings.cm,
            _cmController,
            isCenterText: true,
          ),
        howManyStopsWidget(),
        if (widget.name == Strings.repair) ...[
          labelTextFormFieldWidget(
            Strings.descriptionOfBreakDown,
            'Description here !',
            _descriptionOfBreakDownController,
            isOptional: true,
            isNotes: true,
            isCenterText: true,
          ),
          Gap(AppSize.s25.h),
          pickPhotoOrVideo(),
        ],
        selectSuitableTimeToConductTheSiteSurveyWidget(),
        labelTextFormFieldWidget(
          Strings.notes,
          'notes.',
          _notesController,
          isOptional: true,
          isNotes: true,
          isCenterText: true,
        ),
        Gap(AppSize.s25.h),
        ButtonWidget(radius: AppSize.s14.r, text: Strings.submit, onTap: () {}),
        Gap(AppSize.s14.h),
      ],
    );
  }

  InkWell pickPhotoOrVideo() {
    return InkWell(
      onTap: ()=> _pickImageFromGallery(),
      child: Container(
            height: AppSize.s100.h,
            width: double.infinity.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(AppSize.s12.r),
            ),
            child: DottedBorder(
              options: RectDottedBorderOptions(
                dashPattern: [6, 6],
                color: ColorManager.formFieldsBorderColor,
                strokeWidth: AppSize.s2,
              ),
              child: Center(
                child: _imageFile == null ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageAssets.file),
                    Gap(AppSize.s5.w),
                    Text(
                      Strings.filePhotoOrVideo,
                      style: getRegularTextStyle(
                        color: ColorManager.greyColor,
                        fontSize: FontSizeManager.s16.sp,
                      ),
                    ),
                  ],
                ) : Image.file(_imageFile!),
              ),
            ),
          ),
    );
  }

  Column labelDropDownWidget(
    String title,
    List<String> dropDownItems,
    String? selectedValue,
    void Function(String?) onChanged, [
    bool isOptional = false,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(title, isOptional: isOptional),
        Gap(AppSize.s8.h),
        buildItemsDropDown(dropDownItems, selectedValue, onChanged),
      ],
    );
  }

  Column labelTextFormFieldWidget(
    String title,
    String hintText,
    TextEditingController controller, {
    bool isOptional = false,
    bool isCenterText = false,
    bool isNotes = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s10.h),
        LabelField(title, isOptional: isOptional),
        Gap(AppSize.s8.h),
        TextFromFieldWidget(
          hintText: hintText,
          controller: controller,
          centerText: isCenterText,
          isNotes: isNotes,
        ),
      ],
    );
  }

  Column labelYesOrNoWidget(
    String title,
    bool condition,
    void Function() onYesTap,
    void Function() onNoTap, [
    bool isOptional = false,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelField(title, isOptional: isOptional),
        Gap(AppSize.s8.h),
        YesOrNoButton(
          condition: condition,
          onYesTap: onYesTap,
          onNoTap: onNoTap,
        ),
      ],
    );
  }

  Column selectSuitableTimeToConductTheSiteSurveyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            disabledDays: disabledDays,
            focusedDay: DateTime.now(),
          ),
        ),
      ],
    );
  }

  Column howManyStopsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        Row(
          children: [
            LabelField(Strings.howManyStops, isOptional: true),
            Spacer(),
            Icon(
              Icons.report_gmailerrorred_outlined,
              color: ColorManager.greyColor,
            ),
          ],
        ),
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
                centerText: true,
              ),
            ),
            Gap(AppSize.s5.w),
            Text(
              widget.name == 'New Product'
                  ? _displayedNumber.toString()
                  : " = ${_displayedNumber.toString()}",
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
      ],
    );
  }

  Column doesTheShaftHaveAMachineRoomWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelField(Strings.doesTheShaftHaveAMachineRoom, isOptional: true),
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
      ],
    );
  }

  Column pitDepthAndLastFloorHeightWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        Row(
          children: [
            LabelField(Strings.pitDepth, isOptional: true),
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
      ],
    );
  }

  Column shaftDimensionsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelField(Strings.shaftDimensions, isOptional: true),
        Gap(AppSize.s8.h),
        theTwoFormFields(
          _widthController,
          _depthController,
          Strings.widthCm,
          Strings.depthCm,
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
            centerText: true,
          ),
        ),
        Gap(AppSize.s8.w),
        Expanded(
          child: TextFromFieldWidget(
            hintText: secondText,
            controller: secondController,
            keyboardType: TextInputType.number,
            centerText: true,
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

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }
}

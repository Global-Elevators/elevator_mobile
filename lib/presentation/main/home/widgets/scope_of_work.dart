import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/main/home/widgets/label_drop_down_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_text_form_field_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_yes_or_no_widget.dart';
import 'package:elevator/presentation/main/home/widgets/pick_image_widget.dart';
import 'package:elevator/presentation/main/home/widgets/select_suitable_time_widget.dart';
import 'package:elevator/presentation/main/home/widgets/shaft_dimensions_widget.dart';
import 'package:elevator/presentation/main/home/widgets/stops_input_row.dart';
import 'package:elevator/presentation/main/widgets/yes_or_no_button.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        LabelTextFormFieldWidget(
          title: Strings.projectAddress.tr(),
          hintText: Strings.projectAddress.tr(),
          controller: _projectAddressController,
        ),
        Gap(AppSize.s25.h),
        LabelDropDownWidget(
          title: Strings.projectType.tr(),
          dropDownItems: projectTypeItems,
          selectedValue: selectedProjectType,
          onChanged: (value) => setState(() => selectedProjectType = value),
        ),
        if (widget.name == Strings.newProduct.tr()) Gap(AppSize.s25.h),
        if (widget.name == Strings.annualPreventiveMaintenance.tr() ||
            widget.name == Strings.repair.tr()) ...[
          Gap(AppSize.s25.h),
          LabelYesOrNoWidget(
            title: Strings.isTheElevatorUnderWarranty.tr(),
            condition: isTheElevatorUnderWarranty,
            onYesTap: () => setState(() => isTheElevatorUnderWarranty = false),
            onNoTap: () => setState(() => isTheElevatorUnderWarranty = true),
          ),
          Gap(AppSize.s25.h),
          LabelTextFormFieldWidget(
            title: Strings.elevatorBrand.tr(),
            hintText: Strings.elevatorBrand.tr(),
            controller: _elevatorBrandController,
          ),
        ],
        if (widget.name == Strings.newProduct.tr())
          LabelDropDownWidget(
            title: Strings.shaftType.tr(),
            dropDownItems: shaftTypeItems,
            selectedValue: selectedShaftType,
            onChanged: (value) {
              setState(() {
                selectedShaftType = value;
              });
            },
          ),
        Gap(AppSize.s25.h),
        LabelDropDownWidget(
          title: Strings.shaftLocation.tr(),
          dropDownItems: shaftLocationItems,
          selectedValue: selectedShaftLocation,
          onChanged: (value) {
            setState(() {
              selectedShaftLocation = value;
            });
          },
        ),
        if (widget.name == Strings.newProduct.tr())
          ShaftDimensionsWidget(
            widthController: _widthController,
            depthController: _depthController,
          ),
        if (widget.name == Strings.newProduct.tr())
          pitDepthAndLastFloorHeightWidget(),
        if (widget.name == Strings.newProduct.tr()) ...[
          Gap(AppSize.s25.h),
          LabelYesOrNoWidget(
            title: Strings.doesTheShaftHaveAMachineRoom.tr(),
            condition: doesTheShaftHaveAMachineRoom,
            onYesTap: () =>
                setState(() => doesTheShaftHaveAMachineRoom = false),
            onNoTap: () => setState(() => doesTheShaftHaveAMachineRoom = true),
          ),
          LabelTextFormFieldWidget(
            title: Strings.height.tr(),
            hintText: Strings.cm.tr(),
            controller: _cmController,
            isCenterText: true,
          ),
          Gap(AppSize.s25.h),
        ],
        if (widget.name == Strings.annualPreventiveMaintenance.tr() ||
            widget.name == Strings.repair.tr())
          Gap(AppSize.s25.h),
        StopsInputRow(
          controller: _stopsController,
          displayedNumber: _displayedNumber,
        ),
        Gap(AppSize.s25.h),
        if (widget.name == Strings.repair.tr()) ...[
          LabelTextFormFieldWidget(
            title: Strings.descriptionOfBreakDown.tr(),
            hintText: 'Description here !',
            controller: _descriptionOfBreakDownController,
            isOptional: true,
            isNotes: true,
            isCenterText: true,
          ),
          Gap(AppSize.s25.h),
          CustomImagePicker(
            singleImage: _imageFile,
            onTap: () => _pickImageFromGallery(),
            placeholderText: Strings.filePhotoOrVideo.tr(),
          ),
          Gap(AppSize.s25.h),
        ],
        SelectSuitableTimeWidget(
          disabledDays: disabledDays,
          focusedDay: DateTime.now(),
        ),
        LabelTextFormFieldWidget(
          title: Strings.notes.tr(),
          hintText: 'notes.',
          controller: _notesController,
          isOptional: true,
          isNotes: true,
          isCenterText: true,
        ),
        Gap(AppSize.s25.h),
        InputButtonWidget(
          radius: AppSize.s14.r,
          text: Strings.submit.tr(),
          onTap: () {},
        ),
        Gap(AppSize.s14.h),
      ],
    );
  }

  Column doesTheShaftHaveAMachineRoomWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelField(Strings.doesTheShaftHaveAMachineRoom.tr(), isOptional: true),
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
            LabelField(Strings.pitDepth.tr(), isOptional: true),
            Spacer(),
            LabelField(Strings.lastFloorHeight.tr()),
          ],
        ),
        Gap(AppSize.s8.h),
        theTwoFormFields(
          _pitDepthCmController,
          _lastFloorHeightCmController,
          Strings.cm.tr(),
          Strings.cm.tr(),
        ),
      ],
    );
  }

  Column shaftDimensionsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelField(Strings.shaftDimensions.tr(), isOptional: true),
        Gap(AppSize.s8.h),
        theTwoFormFields(
          _widthController,
          _depthController,
          Strings.widthCm.tr(),
          Strings.depthCm.tr(),
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

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }
}

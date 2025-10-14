import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/main/home/request_site_survey/request_site_survey_viewmodel.dart';
import 'package:elevator/presentation/main/home/widgets/label_drop_down_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_text_form_field_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_yes_or_no_widget.dart';
import 'package:elevator/presentation/main/home/widgets/pick_image_widget.dart';
import 'package:elevator/presentation/main/home/widgets/select_suitable_time_widget.dart';
import 'package:elevator/presentation/main/home/widgets/shaft_dimensions_widget.dart';
import 'package:elevator/presentation/main/home/widgets/stops_input_row.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ScopeOfWork extends StatefulWidget {
  final String scopeOfWork;
  final RequestSiteSurveyViewmodel viewmodel;

  const ScopeOfWork(this.scopeOfWork, this.viewmodel, {super.key});

  @override
  State<ScopeOfWork> createState() => _ScopeOfWorkState();
}

class _ScopeOfWorkState extends State<ScopeOfWork> {
  // Controllers
  final _projectAddressController = TextEditingController();
  final _widthController = TextEditingController();
  final _depthController = TextEditingController();
  final _pitDepthCmController = TextEditingController();
  final _lastFloorHeightCmController = TextEditingController();
  final _cmController = TextEditingController();
  final _stopsController = TextEditingController();
  final _notesController = TextEditingController();
  final _elevatorBrandController = TextEditingController();
  final _descriptionOfBreakDownController = TextEditingController();

  // State
  // final viewmodel = instance<RequestSiteSurveyViewmodel>();
  String? selectedProjectType,
      selectedShaftLocation,
      selectedShaftType,
      selectedElevatorType;
  bool doesTheShaftHaveAMachineRoom = false;
  bool isTheElevatorUnderWarranty = false;
  int _displayedNumber = 0;
  File? _imageFile;
  DateTime? focusedDay;
  String _selectedDay = "";

  // Data
  final projectTypeItems = [
    "villa",
    "residential building",
    "commercial building",
    "mall",
    "hospital",
    "clinic",
    "supermarket",
    "factory",
    "school",
    "university",
  ];

  final shaftTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];
  final shaftLocationItems = ["Cairo", "Alex", "Mansoura", "Giza"];
  final elevatorTypeItems = ["hydraulic", "Alex", "Mansoura", "Giza"];
  final disabledDays = [
    DateTime.utc(2025, 9, 15),
    DateTime.utc(2025, 9, 18),
    DateTime.utc(2025, 9, 20),
  ];

  @override
  void initState() {
    super.initState();
    _stopsController.addListener(_updateDisplayedNumber);
    widget.viewmodel.setScopeOfWork(widget.scopeOfWork);
    _projectAddressController.addListener(
      () => widget.viewmodel.setProjectAddress(_projectAddressController.text),
    );

    _widthController.addListener(
      () => widget.viewmodel.setWidth(_widthController.text),
    );
    _depthController.addListener(
      () => widget.viewmodel.setDepth(_depthController.text),
    );
    _pitDepthCmController.addListener(
      () => widget.viewmodel.setPitDepthCm(_pitDepthCmController.text),
    );
    _lastFloorHeightCmController.addListener(
      () => widget.viewmodel.setLastFloorHeightCm(
        _lastFloorHeightCmController.text,
      ),
    );
    _cmController.addListener(
      () => widget.viewmodel.setHeight(_cmController.text),
    );
    _stopsController.addListener(
      () => widget.viewmodel.setNumberOfStops(_stopsController.text),
    );

    _notesController.addListener(
      () => widget.viewmodel.setNotes(_notesController.text),
    );

    _elevatorBrandController.addListener(
      () => widget.viewmodel.setElevatorBrand(_elevatorBrandController.text),
    );

    _descriptionOfBreakDownController.addListener(
      () => widget.viewmodel.setDescriptionOfBreakdown(
        _descriptionOfBreakDownController.text,
      ),
    );
    _updateDisplayedNumber();
    isRequestCorrect();
  }

  void isRequestCorrect() {
    widget.viewmodel.isUserRequestSiteSurvey.stream.listen((
      isUserRequestSiteSurvey,
    ) {
      if (isUserRequestSiteSurvey) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.go(LoginView.loginRoute);
        });
      }
    });
  }

  void _updateDisplayedNumber() {
    final text = _stopsController.text;
    if (text.isNotEmpty && int.tryParse(text) != null) {
      setState(() => _displayedNumber = int.parse(text) + 1);
    }
  }

  @override
  void dispose() {
    for (var c in [
      _projectAddressController,
      _widthController,
      _depthController,
      _pitDepthCmController,
      _lastFloorHeightCmController,
      _cmController,
      _stopsController,
      _notesController,
      _elevatorBrandController,
      _descriptionOfBreakDownController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _imageFile = File(picked.path));
    widget.viewmodel.setImageFile(_imageFile);
  }

  bool get isNewProduct => widget.scopeOfWork == Strings.newProduct.tr();

  bool get isRepair => widget.scopeOfWork == Strings.repair.tr();

  bool get isMaintenance =>
      widget.scopeOfWork == Strings.annualPreventiveMaintenance.tr();

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Column _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProjectSection(),
        if (isMaintenance || isRepair) _buildWarrantySection(),
        if (isNewProduct) _buildNewProductSection(),
        _buildStopsSection(),
        if (isRepair) _buildRepairSection(),
        _buildScheduleSection(),
        _buildNotesSection(),
        _buildSubmitButton(),
        Gap(AppSize.s25.h),
      ],
    );
  }

  // ----------------------------
  // 🔹 Section Builders
  // ----------------------------

  Widget _buildProjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextFormFieldWidget(
          title: Strings.projectAddress.tr(),
          hintText: Strings.projectAddress.tr(),
          controller: _projectAddressController,
          isButtonEnabledStream: widget.viewmodel.outIsProjectAddressValid,
        ),
        LabelDropDownWidget(
          title: Strings.projectType.tr(),
          dropDownItems: projectTypeItems,
          selectedValue: selectedProjectType,
          onChanged: (value) => setState(() {
            selectedProjectType = value;
            widget.viewmodel.setProjectType(selectedProjectType ?? "");
          }),
        ),
        Gap(AppSize.s25.h),
        LabelDropDownWidget(
          isOptional: true,
          title: Strings.shaftLocation.tr(),
          dropDownItems: shaftLocationItems,
          selectedValue: selectedShaftLocation,
          onChanged: (value) => setState(() {
            selectedShaftLocation = value;
            widget.viewmodel.setShaftLocation(selectedShaftLocation ?? "");
          }),
        ),
      ],
    );
  }

  Widget _buildWarrantySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelYesOrNoWidget(
          title: Strings.isTheElevatorUnderWarranty.tr(),
          condition: isTheElevatorUnderWarranty,
          onYesTap: () => setState(() {
            isTheElevatorUnderWarranty = true;
            widget.viewmodel.setUnderWarrantyOrContract(true);
          }),
          onNoTap: () => setState(() {
            isTheElevatorUnderWarranty = false;
            widget.viewmodel.setUnderWarrantyOrContract(false);
          }),
        ),
        Gap(AppSize.s25.h),
        LabelTextFormFieldWidget(
          isOptional: true,
          title: Strings.elevatorBrand.tr(),
          hintText: Strings.elevatorBrand.tr(),
          controller: _elevatorBrandController,
          isButtonEnabledStream: null,
        ),
        LabelDropDownWidget(
          isOptional: true,
          title: Strings.elevatorType.tr(),
          dropDownItems: elevatorTypeItems,
          selectedValue: selectedElevatorType,
          onChanged: (value) => setState(() {
            selectedElevatorType = value;
            widget.viewmodel.setElevatorType(selectedElevatorType ?? "");
          }),
        ),
        Gap(AppSize.s25.h),
      ],
    );
  }

  Widget _buildNewProductSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelDropDownWidget(
          isOptional: true,
          title: Strings.shaftType.tr(),
          dropDownItems: shaftTypeItems,
          selectedValue: selectedShaftType,
          onChanged: (value) => setState(() {
            selectedShaftType = value;
            widget.viewmodel.setShaftType(selectedShaftType ?? "");
          }),
        ),
        ShaftDimensionsWidget(
          widthController: _widthController,
          depthController: _depthController,
        ),
        _buildPitDepthAndLastFloor(),
        LabelYesOrNoWidget(
          title: Strings.doesTheShaftHaveAMachineRoom.tr(),
          condition: doesTheShaftHaveAMachineRoom,
          onYesTap: () => setState(() {
            doesTheShaftHaveAMachineRoom = false;
            widget.viewmodel.setMachineRoom(false);
          }),
          onNoTap: () => setState(() {
            doesTheShaftHaveAMachineRoom = true;
            widget.viewmodel.setMachineRoom(true);
          }),
        ),
        Gap(AppSize.s10.h),
        LabelTextFormFieldWidget(
          title: Strings.height.tr(),
          hintText: Strings.cm.tr(),
          controller: _cmController,
          isCenterText: true,
          isButtonEnabledStream: widget.viewmodel.outIsHeightValid,
        ),
      ],
    );
  }

  Widget _buildStopsSection() {
    return Column(
      children: [
        StopsInputRow(
          controller: _stopsController,
          displayedNumber: _displayedNumber,
        ),
      ],
    );
  }

  Widget _buildRepairSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextFormFieldWidget(
          title: Strings.descriptionOfBreakDown.tr(),
          hintText: 'Description here !',
          controller: _descriptionOfBreakDownController,
          isOptional: true,
          isNotes: true,
          isCenterText: true,
          isButtonEnabledStream: null,
        ),
        CustomImagePicker(
          singleImage: _imageFile,
          onTap: _pickImageFromGallery,
          placeholderText: Strings.filePhotoOrVideo.tr(),
        ),
        Gap(AppSize.s25.h),
      ],
    );
  }

  Widget _buildPitDepthAndLastFloor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            LabelField(Strings.pitDepth.tr(), isOptional: true),
            const Spacer(),
            LabelField(Strings.lastFloorHeight.tr()),
          ],
        ),
        Gap(AppSize.s8.h),
        Row(
          children: [
            Expanded(
              child: TextFromFieldWidget(
                hintText: Strings.cm.tr(),
                controller: _pitDepthCmController,
                keyboardType: TextInputType.number,
                centerText: true,
              ),
            ),
            Gap(AppSize.s8.w),
            Expanded(
              child: TextFromFieldWidget(
                hintText: Strings.cm.tr(),
                controller: _lastFloorHeightCmController,
                keyboardType: TextInputType.number,
                centerText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScheduleSection() {
    return SelectSuitableTimeWidget(
      disabledDays: disabledDays,
      focusedDay: focusedDay ?? DateTime.now(),
      onDaySelected: (selectedDay, newFocusedDay) {
        setState(() {
          focusedDay = newFocusedDay;
          _selectedDay =
              "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}";
        });
        print(_selectedDay);
        widget.viewmodel.setScheduleDate(_selectedDay);
      },
    );
  }

  Widget _buildNotesSection() {
    return LabelTextFormFieldWidget(
      title: Strings.notes.tr(),
      hintText: 'notes.',
      controller: _notesController,
      isOptional: true,
      isNotes: true,
      isCenterText: true,
      isButtonEnabledStream: null,
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.only(top: AppSize.s25.h),
      child: InputButtonWidget(
        radius: AppSize.s14.r,
        text: Strings.submit.tr(),
        onTap: () => widget.viewmodel.submitSiteSurvey(),
        isButtonEnabledStream: widget.viewmodel.outAreAllInputsValid,
      ),
    );
  }
}

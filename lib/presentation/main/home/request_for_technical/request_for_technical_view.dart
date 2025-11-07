import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/network_aware_widget.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/main/home/request_for_technical/request_for_technical_viewmodel.dart';
import 'package:elevator/presentation/main/home/widgets/label_drop_down_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_text_form_field_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_yes_or_no_widget.dart';
import 'package:elevator/presentation/main/home/widgets/pick_image_widget.dart';
import 'package:elevator/presentation/main/home/widgets/select_suitable_time_widget.dart';
import 'package:elevator/presentation/main/home/widgets/shaft_dimensions_widget.dart';
import 'package:elevator/presentation/main/home/widgets/stops_input_row.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/app_bar_label.dart';
import 'package:elevator/presentation/widgets/back_button.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RequestForTechnicalView extends StatefulWidget {
  static const String requestForTechnicalRoute = '/requestForTechnical';

  const RequestForTechnicalView({super.key});

  @override
  State<RequestForTechnicalView> createState() =>
      _RequestForTechnicalViewState();
}

class _RequestForTechnicalViewState extends State<RequestForTechnicalView> {
  // 📌 Controllers
  final _firstNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _grandFatherNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _projectAddressController = TextEditingController();
  final _widthController = TextEditingController();
  final _depthController = TextEditingController();
  final _pitDepthController = TextEditingController();
  final _heightController = TextEditingController();
  final _stopsController = TextEditingController();
  final _lastFloorHeightController = TextEditingController();
  final _requiredDoorWidthController = TextEditingController();
  final _notesController = TextEditingController();
  final RequestForTechnicalViewmodel _viewmodel =
      instance<RequestForTechnicalViewmodel>();

  // 📌 State variables
  int _displayedNumber = 0;
  bool isProjectBelongsToSameAccount = false;
  bool doesTheShaftHaveAMachineRoom = false;
  bool isMapVisible = false;
  DateTime? focusedDay;
  String _selectedDay = "";

  // 📌 Location
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _googleMapController;
  final Set<Marker> _markers = {};
  LatLng? _currentLatLng;

  // 📌 Images
  List<XFile>? imageFileList = [];

  // 📌 Dropdowns
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

  final List<String> shaftTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];
  final List<String> shaftLocationItems = ["Cairo", "Alex", "Mansoura", "Giza"];
  String? selectedShaftLocation;
  String? selectedShaftType;
  String? selectedProjectType;

  // 📌 Calendar
  final List<DateTime> disabledDays = [
    DateTime.utc(2025, 9, 15),
    DateTime.utc(2025, 9, 18),
    DateTime.utc(2025, 9, 20),
  ];

  @override
  void initState() {
    super.initState();
    _stopsController.addListener(_updateDisplayedNumber);
    _loadCurrentLocation();

    // Add listeners for user info (name, phone, etc.)
    updatingPhoneAndNamesValues();

    // Project info
    _projectAddressController.addListener(
      () => _viewmodel.setProjectAddress(_projectAddressController.text),
    );

    // Shaft / Technical info
    _widthController.addListener(
      () => _viewmodel.setWidth(_widthController.text),
    );
    _depthController.addListener(
      () => _viewmodel.setDepth(_depthController.text),
    );
    _pitDepthController.addListener(
      () => _viewmodel.setPitDepthCm(_pitDepthController.text),
    );
    _heightController.addListener(
      () => _viewmodel.setHeight(_heightController.text),
    );
    _stopsController.addListener(
      () => _viewmodel.setNumberOfStops(_stopsController.text),
    );
    _lastFloorHeightController.addListener(
      () => _viewmodel.setLastFloorHeightCm(_lastFloorHeightController.text),
    );
    _requiredDoorWidthController.addListener(
      () => _viewmodel.setRequiredDoorWidth(_requiredDoorWidthController.text),
    );

    // Notes
    _notesController.addListener(
      () => _viewmodel.setNotes(_notesController.text),
    );

    isRequestCorrect();
  }

  @override
  void dispose() {
    super.dispose();
    _stopsController.removeListener(_updateDisplayedNumber);
    _firstNameController.dispose();
    _fatherNameController.dispose();
    _grandFatherNameController.dispose();
    _phoneNumberController.dispose();
    _projectAddressController.dispose();
    _widthController.dispose();
    _depthController.dispose();
    _pitDepthController.dispose();
    _heightController.dispose();
    _stopsController.dispose();
    _lastFloorHeightController.dispose();
    _requiredDoorWidthController.dispose();
    _notesController.dispose();
  }

  void updatingPhoneAndNamesValues() {
    // User Info
    _phoneNumberController.addListener(
      () => _viewmodel.setPhoneNumber(_phoneNumberController.text),
    );
    _firstNameController.addListener(
      () => _viewmodel.setName(_firstNameController.text),
    );
    _fatherNameController.addListener(
      () => _viewmodel.setSirName(_fatherNameController.text),
    );
    _grandFatherNameController.addListener(
      () => _viewmodel.setMiddleName(_grandFatherNameController.text),
    );
  }

  void _updateDisplayedNumber() {
    if (_stopsController.text.isEmpty) return;
    setState(() {
      final number = int.tryParse(_stopsController.text) ?? 0;
      _displayedNumber = number + 1;
    });
  }

  Future<void> _loadCurrentLocation() async {
    try {
      Position position = await _getUserCurrentLocation();
      _currentLatLng = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: _currentLatLng!,
          infoWindow: const InfoWindow(title: 'My Current Location'),
        ),
      );
      _googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLatLng!, zoom: 15),
        ),
      );
      setState(() => isMapVisible = true);
      _viewmodel.setLatitude(position.latitude);
      _viewmodel.setLongitude(position.longitude);
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  Future<Position> _getUserCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions permanently denied");
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void isRequestCorrect() {
    _viewmodel.isUserRequestSiteSurvey.stream.listen((
      isUserRequestForTechnical,
    ) {
      if (isUserRequestForTechnical) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.go(LoginView.loginRoute);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      onlineChild: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: StreamBuilder<FlowState>(
            stream: _viewmodel.outputStateStream,
            builder: (context, snapshot) {
              return snapshot.data?.getStateWidget(
                    context,
                    _getContentWidget(),
                    () {},
                  ) ??
                  _getContentWidget();
            },
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _getContentWidget() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Gap(AppSize.s25.h),
          _buildProjectOwnershipSection(),
          Gap(AppSize.s25.h),
          _buildPersonalInfoSection(),
          _buildContactSection(),
          _buildProjectDetailsSection(),
          Gap(AppSize.s25.h),
          _buildMapSection(),
          Gap(AppSize.s25.h),
          _buildShaftInfoSection(),
          _buildStopsSection(),
          _buildAttachmentsSection(),
          Gap(AppSize.s25.h),
          _buildScheduleSection(),
          Gap(AppSize.s25.h),
          _buildNotesSection(),
          _buildSubmitButton(),
          Gap(AppSize.s14.h),
        ],
      ),
    );
  }

  // 🧩 Header
  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(child: AppBarLabel(Strings.requestTechnicalOffer.tr())),
        BackButtonWidget(popOrGo: true),
      ],
    );
  }

  // 🧩 Project Ownership
  Widget _buildProjectOwnershipSection() {
    return LabelYesOrNoWidget(
      title: Strings.doesProjectBelongToSameAccount.tr(),
      condition: isProjectBelongsToSameAccount,
      onYesTap: () => setState(() => isProjectBelongsToSameAccount = true),
      onNoTap: () => setState(() => isProjectBelongsToSameAccount = false),
    );
  }

  // 🧩 Personal Info
  Widget _buildPersonalInfoSection() {
    return BuildNameSection(
      firstNameController: _firstNameController,
      fatherNameController: _fatherNameController,
      grandFatherNameController: _grandFatherNameController,
      nameStream: _viewmodel.outIsNameValid,
      fatherNameStream: _viewmodel.outIsSirNameValid,
      grandFatherNameStream: _viewmodel.outIsMiddleNameValid,
    );
  }

  // 🧩 Contact Info
  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.phoneNumberWhatsapp.tr()),
        PhoneField(
          controller: _phoneNumberController,
          phoneValidationStream: _viewmodel.outIsPhoneNumberValid,
        ),
      ],
    );
  }

  // 🧩 Project Details
  Widget _buildProjectDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextFormFieldWidget(
          title: Strings.projectAddress.tr(),
          hintText: Strings.projectAddress.tr(),
          controller: _projectAddressController,
          isButtonEnabledStream: _viewmodel.outIsProjectAddressValid,
        ),
        LabelDropDownWidget(
          title: Strings.projectType.tr(),
          dropDownItems: projectTypeItems,
          selectedValue: selectedProjectType,
          onChanged: (value) => setState(() {
            selectedProjectType = value;
            _viewmodel.setProjectType(selectedProjectType ?? "");
          }),
        ),
      ],
    );
  }

  // 🧩 Map Section
  Widget _buildMapSection() {
    return AnimatedOpacity(
      opacity: isMapVisible ? 1 : 0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      child: SizedBox(
        height: AppSize.s300.h,
        width: double.infinity,
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target:
                _currentLatLng ??
                const LatLng(30.119036404288565, 31.340033013494114),
            zoom: AppSize.s15,
          ),
          onMapCreated: (controller) {
            _googleMapController = controller;
            _controller.complete(controller);
            if (_currentLatLng != null) {
              _googleMapController!.animateCamera(
                CameraUpdate.newLatLngZoom(_currentLatLng!, AppSize.s15),
              );
            }
            Future.delayed(
              const Duration(milliseconds: 550),
              () => setState(() => isMapVisible = true),
            );
          },
        ),
      ),
    );
  }

  // 🧩 Shaft Info
  Widget _buildShaftInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelDropDownWidget(
          title: Strings.shaftType.tr(),
          dropDownItems: shaftTypeItems,
          selectedValue: selectedShaftType,
          onChanged: (value) => setState(() {
            selectedShaftType = value;
            _viewmodel.setShaftType(selectedShaftType ?? "");
          }),
          isOptional: true,
        ),
        Gap(AppSize.s25.h),
        LabelDropDownWidget(
          isOptional: true,
          title: Strings.shaftLocation.tr(),
          dropDownItems: shaftLocationItems,
          selectedValue: selectedShaftLocation,
          onChanged: (value) => setState(() {
            selectedShaftLocation = value;
            _viewmodel.setShaftLocation(selectedShaftLocation ?? "");
          }),
        ),
        ShaftDimensionsWidget(
          widthController: _widthController,
          depthController: _depthController,
        ),
        LabelTextFormFieldWidget(
          title: Strings.pitDepth.tr(),
          hintText: Strings.cm.tr(),
          controller: _pitDepthController,
          isCenterText: true,
          isOptional: true,
          isButtonEnabledStream: null,
        ),
        LabelYesOrNoWidget(
          title: Strings.doesTheShaftHaveAMachineRoom.tr(),
          isOptional: true,
          condition: doesTheShaftHaveAMachineRoom,
          onYesTap: () => setState(() => doesTheShaftHaveAMachineRoom = true),
          onNoTap: () => setState(() => doesTheShaftHaveAMachineRoom = false),
        ),
        Gap(AppSize.s25.h),
        LabelTextFormFieldWidget(
          title: Strings.height.tr(),
          hintText: Strings.cm.tr(),
          controller: _heightController,
          isCenterText: true,
          isOptional: true,
          isButtonEnabledStream: null,
        ),
      ],
    );
  }

  // 🧩 Stops Section
  Widget _buildStopsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StopsInputRow(
          controller: _stopsController,
          displayedNumber: _displayedNumber,
        ),
        LabelTextFormFieldWidget(
          title: Strings.lastFloorHeight.tr(),
          hintText: Strings.cm.tr(),
          controller: _lastFloorHeightController,
          isCenterText: true,
          isOptional: true,
          isButtonEnabledStream: null,
        ),
        LabelTextFormFieldWidget(
          title: Strings.requiredDoorWidth.tr(),
          hintText: Strings.cm.tr(),
          controller: _requiredDoorWidthController,
          isCenterText: true,
          isOptional: true,
          isButtonEnabledStream: null,
        ),
      ],
    );
  }

  // 🧩 Attachments
  Widget _buildAttachmentsSection() {
    return CustomImagePicker(
      multipleImages: imageFileList,
      isMultiple: true,
      onTap: _pickImagesFromGallery,
      placeholderText: Strings.shaftPhoto2BuildingFrontPhoto1.tr(),
      isImageLoading: _viewmodel.showLoading,
    );
  }

  // 🧩 Schedule
  Widget _buildScheduleSection() {
    return SelectSuitableTimeWidget(
      disabledDays: disabledDays,
      focusedDay: focusedDay ?? DateTime.now(),
      onDaySelected: (selectedDay, newFocusedDay) {
        // setState(() {
        focusedDay = newFocusedDay;
        _selectedDay =
            "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}";
        print(_selectedDay);
        // });
        _viewmodel.setScheduleDate(_selectedDay);
      },
    );
  }

  // 🧩 Notes
  Widget _buildNotesSection() {
    return LabelTextFormFieldWidget(
      title: Strings.notes.tr(),
      hintText: 'notes.',
      controller: _notesController,
      isNotes: true,
      isOptional: true,
      isCenterText: true,
      isButtonEnabledStream: null,
    );
  }

  // 🧩 Submit Button
  Widget _buildSubmitButton() {
    return InputButtonWidget(
      radius: AppSize.s14.r,
      text: Strings.submit.tr(),
      onTap: () => _viewmodel.submitRequestForTechnical(),
      isButtonEnabledStream: _viewmodel.outAreAllInputsValid,
    );
  }

  Future<void> _pickImagesFromGallery() async {
    final picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage(limit: 3);
    setState(() => imageFileList = pickedFiles);
    _viewmodel.setImageFiles(imageFileList);
  }
}

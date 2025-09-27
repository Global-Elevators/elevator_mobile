import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/main/home/widgets/label_drop_down_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_text_form_field_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_yes_or_no_widget.dart';
import 'package:elevator/presentation/main/home/widgets/pick_image_widget.dart';
import 'package:elevator/presentation/main/home/widgets/select_suitable_time_widget.dart';
import 'package:elevator/presentation/main/home/widgets/shaft_dimensions_widget.dart';
import 'package:elevator/presentation/main/home/widgets/stops_input_row.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/back_button.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
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

  // 📌 State variables
  int _displayedNumber = 0;
  bool isProjectBelongsToSameAccount = false;
  bool doesTheShaftHaveAMachineRoom = false;
  bool isMapVisible = false;

  // 📌 Location
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _googleMapController;
  final Set<Marker> _markers = {};
  LatLng? _currentLatLng;

  // 📌 Images
  List<XFile>? imageFileList = [];

  // 📌 Dropdowns
  final List<String> projectTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];
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
  }

  void _updateDisplayedNumber() {
    if (_stopsController.text.isEmpty) return;
    setState(() {
      int number = int.tryParse(_stopsController.text) ?? 0;
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Gap(AppSize.s25.h),
              _buildProjectOwnershipSection(),
              Gap(AppSize.s25.h),
              _buildPersonalInfoSection(),
              Gap(AppSize.s25.h),
              _buildContactSection(),
              Gap(AppSize.s25.h),
              _buildProjectDetailsSection(),
              Gap(AppSize.s25.h),
              _buildMapSection(),
              Gap(AppSize.s25.h),
              _buildShaftInfoSection(),
              Gap(AppSize.s25.h),
              _buildStopsSection(),
              Gap(AppSize.s25.h),
              _buildAttachmentsSection(),
              Gap(AppSize.s25.h),
              _buildScheduleSection(),
              Gap(AppSize.s25.h),
              _buildNotesSection(),
              Gap(AppSize.s25.h),
              _buildSubmitButton(),
              Gap(AppSize.s14.h),
            ],
          ),
        ),
      ),
    );
  }

  // 🧩 Header
  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            Strings.requestTechnicalOffer,
            style: getBoldTextStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeManager.s28,
            ),
          ),
        ),
        BackButtonWidget(popOrGo: true),
      ],
    );
  }

  // 🧩 Project Ownership
  Widget _buildProjectOwnershipSection() {
    return LabelYesOrNoWidget(
      title: Strings.doesProjectBelongToSameAccount,
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
    );
  }

  // 🧩 Contact Info
  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.phoneNumberWhatsapp),
        PhoneField(controller: _phoneNumberController, phoneValidationStream: null),
      ],
    );
  }

  // 🧩 Project Details
  Widget _buildProjectDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextFormFieldWidget(
          title: Strings.projectAddress,
          hintText: Strings.projectAddress,
          controller: _projectAddressController,
        ),
        Gap(AppSize.s25.h),
        LabelDropDownWidget(
          title: Strings.projectType,
          dropDownItems: projectTypeItems,
          selectedValue: selectedProjectType,
          onChanged: (value) => setState(() => selectedProjectType = value),
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
            target: _currentLatLng ?? const LatLng(30.119036404288565, 31.340033013494114),
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
            Future.delayed(const Duration(milliseconds: 550),
                    () => setState(() => isMapVisible = true));
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
          title: Strings.shaftType,
          dropDownItems: shaftTypeItems,
          selectedValue: selectedShaftType,
          onChanged: (value) => setState(() => selectedShaftType = value),
          isOptional: true,
        ),
        Gap(AppSize.s25.h),
        LabelDropDownWidget(
          title: Strings.shaftLocation,
          dropDownItems: shaftLocationItems,
          selectedValue: selectedShaftLocation,
          onChanged: (value) => setState(() => selectedShaftLocation = value),
        ),
        ShaftDimensionsWidget(
          widthController: _widthController,
          depthController: _depthController,
        ),
        Gap(AppSize.s25.h),
        LabelTextFormFieldWidget(
          title: Strings.pitDepth,
          hintText: Strings.cm,
          controller: _pitDepthController,
          isCenterText: true,
          isOptional: true,
        ),
        Gap(AppSize.s25.h),
        LabelYesOrNoWidget(
          title: Strings.doesTheShaftHaveAMachineRoom,
          isOptional: true,
          condition: doesTheShaftHaveAMachineRoom,
          onYesTap: () => setState(() => doesTheShaftHaveAMachineRoom = true),
          onNoTap: () => setState(() => doesTheShaftHaveAMachineRoom = false),
        ),
        Gap(AppSize.s25.h),
        LabelTextFormFieldWidget(
          title: Strings.height,
          hintText: Strings.cm,
          controller: _heightController,
          isCenterText: true,
          isOptional: true,
        ),
      ],
    );
  }

  // 🧩 Stops Section
  Widget _buildStopsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            LabelField(Strings.howManyStops, isOptional: true),
            const Spacer(),
            Icon(Icons.report_gmailerrorred_outlined, color: ColorManager.greyColor),
          ],
        ),
        Gap(AppSize.s8.h),
        StopsInputRow(controller: _stopsController, displayedNumber: _displayedNumber),
        Gap(AppSize.s25.h),
        LabelTextFormFieldWidget(
          title: Strings.lastFloorHeight,
          hintText: Strings.cm,
          controller: _lastFloorHeightController,
          isCenterText: true,
          isOptional: true,
        ),
        Gap(AppSize.s25.h),
        LabelTextFormFieldWidget(
          title: Strings.requiredDoorWidth,
          hintText: Strings.cm,
          controller: _requiredDoorWidthController,
          isCenterText: true,
          isOptional: true,
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
      placeholderText: Strings.shaftPhoto2BuildingFrontPhoto1,
    );
  }

  // 🧩 Schedule
  Widget _buildScheduleSection() {
    return SelectSuitableTimeWidget(
      disabledDays: disabledDays,
      focusedDay: DateTime.now(),
    );
  }

  // 🧩 Notes
  Widget _buildNotesSection() {
    return LabelTextFormFieldWidget(
      title: Strings.notes,
      hintText: 'notes.',
      controller: _notesController,
      isNotes: true,
      isOptional: true,
      isCenterText: true,
    );
  }

  // 🧩 Submit Button
  Widget _buildSubmitButton() {
    return InputButtonWidget(
      radius: AppSize.s14.r,
      text: Strings.submit,
      onTap: () {},
    );
  }

  Future<void> _pickImagesFromGallery() async {
    final picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage(limit: 3);
    setState(() => imageFileList = pickedFiles);
  }
}

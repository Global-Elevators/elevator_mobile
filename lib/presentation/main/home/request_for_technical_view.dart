import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _grandFatherNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _projectAddressController =
      TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();
  final TextEditingController _pitDepthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _stopsController = TextEditingController();
  final TextEditingController _lastFloorHeightController =
      TextEditingController();
  final TextEditingController _requiredDoorWidthController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  int _displayedNumber = 0;
  bool isProjectBelongsToSameAccount = false;
  bool doesTheShaftHaveAMachineRoom = false;

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _googleMapController;

  final Set<Marker> _markers = {};
  bool isMapVisible = false;
  LatLng? _currentLatLng;

  // File? _imageFile;
  List<XFile>? imageFileList = [];

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
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
      // move camera if controller already ready
      if (_googleMapController != null) {
        _googleMapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _currentLatLng!, zoom: 15),
          ),
        );
      }
      setState(() {
        isMapVisible = true;
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  Future<Position> _getUserCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  final List<String> projectTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];
  final List<String> shaftTypeItems = ["Cairo", "Alex", "Mansoura", "Giza"];
  final List<String> shaftLocationItems = ["Cairo", "Alex", "Mansoura", "Giza"];
  String? selectedShaftLocation;
  String? selectedShaftType;
  String? selectedProjectType;
  final List<DateTime> disabledDays = [
    DateTime.utc(2025, 9, 15),
    DateTime.utc(2025, 9, 18),
    DateTime.utc(2025, 9, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: AppPadding.p16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                requestForTechnicalAppBar(),
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
                ),
                Gap(AppSize.s25.h),
                LabelField(Strings.phoneNumberWhatsapp),
                PhoneField(controller: _phoneNumberController, phoneValidationStream: null,),
                Gap(AppSize.s25.h),
                LabelTextFormFieldWidget(
                  title: Strings.projectAddress,
                  hintText: Strings.projectAddress,
                  controller: _projectAddressController,
                ),
                Gap(AppSize.s25.h),
                googleMapWidget(),
                Gap(AppSize.s25.h),
                LabelDropDownWidget(
                  title: Strings.projectType,
                  dropDownItems: projectTypeItems,
                  selectedValue: selectedProjectType,
                  onChanged: (value) =>
                      setState(() => selectedProjectType = value),
                ),
                Gap(AppSize.s25.h),
                LabelDropDownWidget(
                  title: Strings.shaftType,
                  dropDownItems: shaftTypeItems,
                  selectedValue: selectedShaftType,
                  onChanged: (value) {
                    setState(() {
                      selectedShaftType = value;
                    });
                  },
                  isOptional: true,
                ),
                Gap(AppSize.s25.h),
                LabelDropDownWidget(
                  title: Strings.shaftLocation,
                  dropDownItems: shaftLocationItems,
                  selectedValue: selectedShaftLocation,
                  onChanged: (value) {
                    setState(() {
                      selectedShaftLocation = value;
                    });
                  },
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
                  isOptional: true,
                  title: Strings.doesTheShaftHaveAMachineRoom,
                  condition: doesTheShaftHaveAMachineRoom,
                  onYesTap: () =>
                      setState(() => doesTheShaftHaveAMachineRoom = false),
                  onNoTap: () =>
                      setState(() => doesTheShaftHaveAMachineRoom = true),
                ),
                Gap(AppSize.s25.h),
                LabelTextFormFieldWidget(
                  title: Strings.height,
                  hintText: Strings.cm,
                  controller: _heightController,
                  isCenterText: true,
                  isOptional: true,
                ),
                Gap(AppSize.s25.h),
                howManyStopsWidget(),
                Gap(AppSize.s25.h),
                LabelTextFormFieldWidget(
                  title: Strings.lastFloorHeight,
                  isOptional: true,
                  hintText: Strings.cm,
                  controller: _lastFloorHeightController,
                  isCenterText: true,
                ),
                Gap(AppSize.s25.h),
                LabelTextFormFieldWidget(
                  title: Strings.requiredDoorWidth,
                  isOptional: true,
                  hintText: Strings.cm,
                  controller: _requiredDoorWidthController,
                  isCenterText: true,
                ),
                Gap(AppSize.s25.h),
                CustomImagePicker(
                  multipleImages: imageFileList,
                  isMultiple: true,
                  onTap: _pickImagesFromGallery,
                  placeholderText: Strings.shaftPhoto2BuildingFrontPhoto1,
                ),
                Gap(AppSize.s25.h),
                SelectSuitableTimeWidget(
                  disabledDays: disabledDays,
                  focusedDay: DateTime.now(),
                ),
                Gap(AppSize.s25.h),
                LabelTextFormFieldWidget(
                  title: Strings.notes,
                  hintText: 'notes.',
                  controller: _notesController,
                  isOptional: true,
                  isNotes: true,
                  isCenterText: true,
                ),
                Gap(AppSize.s25.h),
                InputButtonWidget(
                  radius: AppSize.s14.r,
                  text: Strings.submit,
                  onTap: () {},
                ),
                Gap(AppSize.s14.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedOpacity googleMapWidget() {
    return animatedOpacity();
  }

  AnimatedOpacity animatedOpacity() {
    return AnimatedOpacity(
      curve: Curves.fastOutSlowIn,
      opacity: isMapVisible ? 1.0 : 0,
      duration: const Duration(milliseconds: 600),
      child: mapSize(),
    );
  }

  SizedBox mapSize() {
    return SizedBox(
      height: AppSize.s300.h,
      width: double.infinity,
      child: googleMapView(),
    );
  }

  GoogleMap googleMapView() {
    return GoogleMap(
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
      onMapCreated: (controller) async {
        _googleMapController = controller;
        _controller.complete(controller);
        if (_currentLatLng != null) {
          _googleMapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_currentLatLng!, AppSize.s15),
          );
        }
        Future.delayed(
          const Duration(milliseconds: 550),
          () => setState(() {
            isMapVisible = true;
          }),
        );
      },
    );
  }

  SizedBox requestForTechnicalAppBar() {
    return SizedBox(
      height: AppSize.s80.h,
      child: Row(
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
          Gap(AppSize.s16.w),
          BackButtonWidget(popOrGo: true),
        ],
      ),
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
        StopsInputRow(
          controller: _stopsController,
          displayedNumber: _displayedNumber,
        ),
      ],
    );
  }

  Future<void> _pickImagesFromGallery() async {
    final picker = ImagePicker();
    final List<XFile> pickedFile = await picker.pickMultiImage(limit: 3);
    setState(() {
      imageFileList = pickedFile;
    });
  }
}

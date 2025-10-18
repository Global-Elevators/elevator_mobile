import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/app/functions.dart';
import 'package:elevator/domain/usecase/technical_commercial_offers_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

import '../../../../data/network/requests/technical_commercial_offers_request.dart';

class RequestForTechnicalViewmodel extends BaseViewModel
    implements
        RequestForTechnicalViewModelInput,
        RequestForTechnicalViewModelOutput {
  final StreamController<String> _nameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _sirNameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _middleNameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _phoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _projectAddressStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController<bool> isUserRequestSiteSurvey = StreamController<bool>();

  String _name = '';
  String _sirName = '';
  String _middleName = '';
  String _phoneNumber = '';

  String _projectAddress = '';
  String _projectType = '';
  String _scheduleDate = '';
  String _notes = '';

  String _shaftType = '';
  String _shaftLocation = '';
  String _width = '';
  String _depth = '';
  String _pitDepthCm = '';
  String _lastFloorHeightCm = '';
  String _requiredDoorWidth = '';
  String _numberOfStops = '';
  String _height = '';

  bool _hasMachineRoom = true;

  final List<String> _photosOrVideos = [];
  List<MultipartFile>? _imageFiles = [];

  double _longitude = 0.0;
  double _latitude = 0.0;

  final TechnicalCommercialOffersUsecase _technicalCommercialOffersUsecase;

  RequestForTechnicalViewmodel(this._technicalCommercialOffersUsecase);

  @override
  void start() => inputState.add(ContentState());

  @override
  void dispose() {
    super.dispose();
    _nameStreamController.close();
    _sirNameStreamController.close();
    _middleNameStreamController.close();
    _phoneNumberStreamController.close();
    _projectAddressStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserRequestSiteSurvey.close();
  }

  @override
  Sink get areAllInputsValidController =>
      _areAllInputsValidStreamController.sink;

  @override
  Sink get inPutMiddleName => _middleNameStreamController.sink;

  @override
  Sink get inPutName => _nameStreamController.sink;

  @override
  Sink get inPutPhoneNumber => _phoneNumberStreamController.sink;

  @override
  Sink get inPutProjectAddress => _projectAddressStreamController.sink;

  @override
  Sink get inPutSirName => _sirNameStreamController.sink;

  @override
  Stream<bool> get outAreAllInputsValid => _areAllInputsValidStreamController
      .stream
      .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outIsMiddleNameValid => _middleNameStreamController.stream
      .map((middleName) => isTextNotEmpty(middleName));

  @override
  Stream<bool> get outIsNameValid =>
      _nameStreamController.stream.map((name) => isTextNotEmpty(name));

  @override
  Stream<bool> get outIsPhoneNumberValid => _phoneNumberStreamController.stream
      .map((phoneNumber) => isPhoneValid(phoneNumber));

  @override
  Stream<bool> get outIsProjectAddressValid => _projectAddressStreamController
      .stream
      .map((projectAddress) => isTextNotEmpty(projectAddress));

  @override
  Stream<bool> get outIsSirNameValid =>
      _sirNameStreamController.stream.map((sirName) => isTextNotEmpty(sirName));

  bool _areAllInputsValid() =>
      isTextNotEmpty(_name) &&
      isTextNotEmpty(_sirName) &&
      isTextNotEmpty(_middleName) &&
      isPhoneValid(_phoneNumber) &&
      isTextNotEmpty(_projectAddress) &&
      isTextNotEmpty(_projectType) &&
      isNumberNotZero(_latitude.toInt()) &&
      isNumberNotZero(_longitude.toInt()) &&
      isTextNotEmpty(_scheduleDate);

  @override
  void setDepth(String depth) {
    _depth = depth;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setHeight(String height) {
    _height = height;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setImageFile(File? imageFile) {}

  @override
  void setLastFloorHeightCm(String lastFloorHeightCm) {
    _lastFloorHeightCm = lastFloorHeightCm;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setLatitude(double latitude) {
    _latitude = latitude;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setLongitude(double longitude) {
    _longitude = longitude;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setMachineRoom(bool hasMachineRoom) {
    _hasMachineRoom = hasMachineRoom;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setMiddleName(String middleName) {
    _middleName = middleName;
    inPutMiddleName.add(middleName);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setName(String name) {
    _name = name;
    inPutName.add(name);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setNotes(String notes) {
    _notes = notes;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setNumberOfStops(String numberOfStops) {
    _numberOfStops = numberOfStops;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    inPutPhoneNumber.add(phoneNumber);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setPitDepthCm(String pitDepthCm) {
    _pitDepthCm = pitDepthCm;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setProjectAddress(String projectAddress) {
    _projectAddress = projectAddress;
    inPutProjectAddress.add(projectAddress);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setProjectType(String projectType) {
    _projectType = projectType;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setRequiredDoorWidth(String requiredDoorWidth) {
    _requiredDoorWidth = requiredDoorWidth;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setScheduleDate(String scheduleDate) {
    _scheduleDate = scheduleDate;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setShaftLocation(String shaftLocation) {
    _shaftLocation = shaftLocation;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setShaftType(String shaftType) {
    _shaftType = shaftType;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setSirName(String sirName) {
    _sirName = sirName;
    inPutSirName.add(sirName);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setWidth(String width) {
    _width = width;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void submitRequestForTechnical() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final userInfo = UserInfo(
        fullName: _name,
        sirName: _sirName,
        middleName: _middleName,
        phone: _phoneNumber,
        email: "",
        company: "",
      );

      final shaftDimensions = ShaftDimensions(
        depth: _depth.isEmpty ? 0 : double.parse(_depth),
        width: _width.isEmpty ? 0 : double.parse(_width),
      );

      final location = MapLocation(latitude: _latitude, longitude: _longitude);

      final extraData = ExtraData(
        height: _height.isEmpty ? 0 : double.parse(_height),
        machineRoom: _hasMachineRoom,
        shaftType: _shaftType.orEmpty(),
        shaftLocation: _shaftLocation.orEmpty(),
        stops: _numberOfStops.isEmpty ? 1 : int.parse(_numberOfStops),
        lastFloorHeight: _lastFloorHeightCm.isEmpty
            ? 0.0
            : double.parse(_lastFloorHeightCm),
        pitDepth: _pitDepthCm.isEmpty ? 0.0 : double.parse(_pitDepthCm),
        shaftDimensions: shaftDimensions,
        photosOrVideos: _photosOrVideos,
        requiredDoorWidth: _requiredDoorWidth.isEmpty
            ? 0
            : double.parse(_requiredDoorWidth),
        mapLocation: location,
      );

      final request = TechnicalCommercialOffersRequest(
        userInfo: userInfo,
        scopeOfWork: "technical_commercial_offer",
        projectAddress: _projectAddress,
        projectType: _projectType,
        scheduleDate: _scheduleDate,
        notes: _notes.orEmpty(),
        extraData: extraData,
      );

      final result = await _technicalCommercialOffersUsecase.execute(request);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          isUserRequestSiteSurvey.add(true);
          // _appPref.logOut("login");
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in requestSiteSurvey: $e\n$stack");
    }
  }

  @override
  void uploadMedia() {}
}

abstract class RequestForTechnicalViewModelInput {
  // Actions
  void submitRequestForTechnical();

  void uploadMedia();

  // User Info
  void setName(String name);

  void setSirName(String sirName);

  void setMiddleName(String middleName);

  void setPhoneNumber(String phoneNumber);

  // Project Info
  void setProjectAddress(String projectAddress);

  void setProjectType(String projectType);

  void setScheduleDate(String scheduleDate);

  void setNotes(String notes);

  // Shaft / Technical Info
  void setShaftType(String shaftType);

  void setShaftLocation(String shaftLocation);

  void setWidth(String width);

  void setDepth(String depth);

  void setPitDepthCm(String pitDepthCm);

  void setLastFloorHeightCm(String lastFloorHeightCm);

  void setNumberOfStops(String numberOfStops);

  void setMachineRoom(bool hasMachineRoom);

  void setHeight(String height);

  void setRequiredDoorWidth(String requiredDoorWidth);

  void setLongitude(double longitude);

  void setLatitude(double latitude);

  // Media
  void setImageFile(File? imageFile);

  // Input Streams (Reactive fields)
  Sink get inPutName;

  Sink get inPutSirName;

  Sink get inPutMiddleName;

  Sink get inPutPhoneNumber;

  Sink get inPutProjectAddress;

  Sink get areAllInputsValidController;
}

abstract class RequestForTechnicalViewModelOutput {
  Stream<bool> get outIsNameValid;

  Stream<bool> get outIsSirNameValid;

  Stream<bool> get outIsMiddleNameValid;

  Stream<bool> get outIsPhoneNumberValid;

  Stream<bool> get outIsProjectAddressValid;

  Stream<bool> get outAreAllInputsValid;
}

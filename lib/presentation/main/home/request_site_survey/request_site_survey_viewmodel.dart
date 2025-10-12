import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/app/functions.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/domain/usecase/request_site_survey_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class RequestSiteSurveyViewmodel extends BaseViewModel
    implements
        RequestSiteSurveyViewModelInput,
        RequestSiteSurveyViewModelOutput {
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
  final StreamController<String> _heightStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController<bool> isUserRequestSiteSurvey =
      StreamController<bool>();

  String _name = '';
  String _sirName = '';
  String _middleName = '';
  String _phoneNumber = '';
  String _projectAddress = '';
  String _notes = '';
  String _height = '';
  bool _hasMachineRoom = false;
  String _scopeOfWork = '';
  String _projectType = '';
  String _scheduleDate = '';
  String _shaftType = '';
  String _shaftLocation = '';
  String _width = '';
  String _depth = '';
  String _pitDepthCm = '';
  String _lastFloorHeightCm = '';
  String _numberOfStops = '';

  final RequestSiteSurveyUsecase _requestSiteSurveyUsecase;
  final _appPref = instance<AppPreferences>();

  RequestSiteSurveyViewmodel(this._requestSiteSurveyUsecase);

  @override
  void start() => inputState.add(ContentState());

  @override
  Sink get areAllInputsValidController =>
      _areAllInputsValidStreamController.sink;

  @override
  Sink get inPutHeight => _heightStreamController.sink;

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
  Stream<bool> get outIsHeightValid =>
      _heightStreamController.stream.map((height) => isTextNotEmpty(height));

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

  @override
  void setName(String name) {
    _name = name;
    inPutName.add(name);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setSirName(String sirName) {
    _sirName = sirName;
    inPutSirName.add(sirName);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setMiddleName(String middleName) {
    _middleName = middleName;
    inPutMiddleName.add(middleName);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    inPutPhoneNumber.add(phoneNumber);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setScopeOfWork(String scopeOfWork) {
    if (scopeOfWork == Strings.repair.tr()) {
      _scopeOfWork = 'repair';
    } else if (scopeOfWork == Strings.annualPreventiveMaintenance.tr()) {
      _scopeOfWork = 'maintenance';
    } else {
      _scopeOfWork = 'new_product';
    }
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setProjectAddress(String projectAddress) {
    _projectAddress = projectAddress;
    inPutProjectAddress.add(projectAddress);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setDepth(String depth) {
    _depth = depth;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setHeight(String height) {
    _height = height;
    inPutHeight.add(height);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setLastFloorHeightCm(String shaftLocation) {
    _lastFloorHeightCm = shaftLocation;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setMachineRoom(bool hasMachineRoom) {
    _hasMachineRoom = hasMachineRoom;
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
  void setPitDepthCm(String pitDepthCm) {
    _pitDepthCm = pitDepthCm;
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setProjectType(String projectType) {
    _projectType = projectType;
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
  void setWidth(String width) {
    _width = width;
    _areAllInputsValidStreamController.add(null);
  }

  bool _areAllInputsValid() =>
      isTextNotEmpty(_name) &&
      isTextNotEmpty(_sirName) &&
      isTextNotEmpty(_middleName) &&
      isPhoneValid(_phoneNumber) &&
      isTextNotEmpty(_scopeOfWork) &&
      isTextNotEmpty(_projectAddress) &&
      isTextNotEmpty(_projectType) &&
      isTextNotEmpty(_height) &&
      isTextNotEmpty(_scheduleDate);

  @override
  void submitSiteSurvey() async {
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
        depth: _depth.isEmpty ? 0 : int.parse(_depth),
        width: _width.isEmpty ? 0 : int.parse(_width),
      );

      final extraData = ExtraData(
        height: _height.isEmpty ? 0 : int.parse(_height),
        machineRoom: _hasMachineRoom,
        shaftType: _shaftType.orEmpty(),
        shaftLocation: _shaftLocation.orEmpty(),
        stops: _numberOfStops.isEmpty ? 1 : int.parse(_numberOfStops),
        lastFloorHeight: _lastFloorHeightCm.isEmpty
            ? 0
            : int.parse(_lastFloorHeightCm),
        pitDepth: _pitDepthCm.isEmpty ? 0 : int.parse(_pitDepthCm),
        shaftDimensions: shaftDimensions,
      );

      final request = RequestSiteSurveyRequest(
        userInfo: userInfo,
        scopeOfWork: _scopeOfWork,
        projectAddress: _projectAddress,
        projectType: _projectType,
        scheduleDate: _scheduleDate,
        notes: _notes.orEmpty(),
        extraData: extraData,
      );

      final result = await _requestSiteSurveyUsecase.execute(request);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          isUserRequestSiteSurvey.add(true);
          _appPref.logOut("login");
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
}

abstract class RequestSiteSurveyViewModelInput {
  void submitSiteSurvey();

  void setName(String name);

  void setSirName(String sirName);

  void setMiddleName(String middleName);

  void setPhoneNumber(String phoneNumber);

  void setScopeOfWork(String scopeOfWork);

  void setProjectAddress(String projectAddress);

  void setProjectType(String projectType);

  void setScheduleDate(String scheduleDate);

  void setNotes(String notes);

  void setShaftType(String shaftType);

  void setShaftLocation(String shaftLocation);

  void setWidth(String width);

  void setDepth(String depth);

  void setPitDepthCm(String pitDepthCm);

  void setLastFloorHeightCm(String shaftLocation);

  void setNumberOfStops(String numberOfStops);

  void setMachineRoom(bool hasMachineRoom);

  void setHeight(String height);

  Sink get inPutName;

  Sink get inPutSirName;

  Sink get inPutMiddleName;

  Sink get inPutPhoneNumber;

  Sink get inPutProjectAddress;

  Sink get inPutHeight;

  Sink get areAllInputsValidController;
}

abstract class RequestSiteSurveyViewModelOutput {
  Stream<bool> get outIsNameValid;

  Stream<bool> get outIsSirNameValid;

  Stream<bool> get outIsMiddleNameValid;

  Stream<bool> get outIsPhoneNumberValid;

  Stream<bool> get outIsProjectAddressValid;

  Stream<bool> get outIsHeightValid;

  Stream<bool> get outAreAllInputsValid;
}

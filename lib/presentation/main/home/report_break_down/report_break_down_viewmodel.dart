import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elevator/data/network/requests/report_break_down_request.dart';
import 'package:elevator/domain/usecase/report_break_down_usecase.dart';
import 'package:elevator/domain/usecase/upload_media_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class ReportBreakDownViewmodel extends BaseViewModel {
  final String _notes = '';
  bool showLoading = false;
  List<MultipartFile>? _imageFiles = [];
  final List<String> _photosOrVideos = [];
  final StreamController<bool> isReportBreakDownSuccessfullyController =
  StreamController<bool>.broadcast();

  final ReportBreakDownUsecase _reportBreakDownUsecase;

  final UploadedMediaUseCase _uploadMediaUsecase;

  ReportBreakDownViewmodel(
    this._reportBreakDownUsecase,
    this._uploadMediaUsecase,
  );

  void setImageFile(File? imageFile) async {
    if (imageFile != null) {
      final fileName = imageFile.path.split('/').last;

      final multipartFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      );

      _imageFiles ??= [];
      _imageFiles!.add(multipartFile);

      await uploadMedia();
    }
  }

  @override
  void start() => inputState.add(ContentState());

  Future<void> uploadMedia() async {
    try {
      showLoading = true;

      if (_imageFiles == null || _imageFiles!.isEmpty) {
        inputState.add(
          ErrorState(
            StateRendererType.popUpErrorState,
            "No image selected for upload.",
          ),
        );
        return;
      }

      final result = await _uploadMediaUsecase.execute(_imageFiles!);

      result.fold(
        (failure) {
          showLoading = false;
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          showLoading = false;
          inputState.add(SuccessState("Image uploaded successfully"));

          final uploadedIds = data.data.uploads
              .map((upload) => upload.id)
              .toList();

          _photosOrVideos.addAll(uploadedIds);

          debugPrint("✅ Uploaded media IDs: $_photosOrVideos");
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in uploadMedia: $e\n$stack");
    }
  }

  Future<void> reportBreakDown() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _reportBreakDownUsecase.execute(
        ReportBreakDownRequest(
          notes: _notes,
          photosOrVideos: _photosOrVideos,
          hasInjury: true,
        ),
      );

      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          isReportBreakDownSuccessfullyController.add(true);
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in reportBreakDown: $e\n$stack");
    }
  }
}

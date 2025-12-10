import 'dart:async';
import 'package:elevator/domain/models/request_status_model.dart';
import 'package:elevator/domain/usecase/request_status_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class RequestStatusViewModel extends BaseViewModel {
  final RequestStatusUsecase _requestStatusUsecase;

  RequestStatusViewModel(this._requestStatusUsecase);

  @override
  void start() => getRequestStatus();

  // Expose a typed list directly for the view to consume
  List<RequestStatusDataModel> requests = [];

  Future<void> getRequestStatus() async {
    try {
      inputState.add(
        LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
      );

      final result = await _requestStatusUsecase.execute(null);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.fullScreenErrorState, failure.message),
          );
        },
        (data) {
          requests = data.requests;
          inputState.add(ContentState());
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.fullScreenErrorState,
          "Unexpected error occurred",
        ),
      );
      debugPrint("🔥 Exception in getRequestStatus(): $e\n$stack");
    }
  }
}

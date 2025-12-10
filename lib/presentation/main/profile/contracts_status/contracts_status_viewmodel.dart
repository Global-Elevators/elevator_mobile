import 'package:elevator/domain/models/contracts_status_model.dart';
import 'package:elevator/domain/usecase/contracts_status_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class ContractsStatusViewModel extends BaseViewModel {
  final ContractsStatusUsecase _contractsStatusUsecase;

  ContractsStatusViewModel(this._contractsStatusUsecase);

  @override
  void start() => getContractsStatus();

  ContractsStatusModel? contractsStatusModel;

  Future<void> getContractsStatus() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );

    try {
      final result = await _contractsStatusUsecase.execute(null);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.fullScreenErrorState, failure.message),
          );
        },
        (data) {
          contractsStatusModel = data;
          final contracts = data.contracts;
          if (contracts.isEmpty) {
            inputState.add(EmptyState("No contract status available."));
          } else {
            inputState.add(ContentState());
          }
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in getContractsStatus(): $e\n$stack");
    }
  }
}

import 'package:elevator/domain/models/library_model.dart';
import 'package:elevator/domain/usecase/library_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/foundation.dart';

class LibraryViewModel extends BaseViewModel {
  final LibraryUsecase _libraryUsecase;

  LibraryViewModel(this._libraryUsecase);

  @override
  void start() => getLibrary();

  LibraryAttachment? libraryAttachment;

  Future<void> getLibrary() async {

    try {
      final result = await _libraryUsecase.execute(null);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.fullScreenErrorState, failure.message),
          );
        },
        (data) {
          libraryAttachment = data;

          final hasData = data.data != null && data.data!.isNotEmpty;

          if (!hasData) {
            inputState.add(EmptyState("No library data found."));
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
      debugPrint("🔥 Exception in getLibrary(): $e\n$stack");
    }
  }
}

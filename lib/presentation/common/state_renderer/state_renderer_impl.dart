import 'package:elevator/app/constants.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  LoadingState({
    required this.stateRendererType,
    this.message = Strings.loading,
  });

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

class ContentState extends FlowState {
  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

  @override
  String getMessage() => Constants.empty;
}

class EmptyState extends FlowState {
  final String message;

  EmptyState(this.message);

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;

  @override
  String getMessage() => message;
}

class SuccessState extends FlowState {
  final String message;

  SuccessState(this.message);

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popUpSuccessState;

  @override
  String getMessage() => message;
}

extension FlowStateExtension on FlowState {
  Widget getStateWidget(
    BuildContext context,
    Widget contentScreen,
    Function retryActionFunction,
  ) {
    switch (this) {
      case LoadingState _:
        return _handlePopupOrFull(context, contentScreen, retryActionFunction);

      case ErrorState _:
        return _handlePopupOrFull(context, contentScreen, retryActionFunction);

      case ContentState _:
        _dismissDialog(context);
        return contentScreen;

      case EmptyState _:
        _dismissDialog(context);
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          retryActionFunction: retryActionFunction,
          message: getMessage(),
        );

      case SuccessState _:
        _dismissDialog(context);
        _showPopup(
          context,
          getStateRendererType(),
          getMessage(),
          title: Strings.success,
        );
        return contentScreen;
      default:
        _dismissDialog(context);
        return contentScreen;
    }
  }

  // Handle loading/error in popup or fullscreen
  Widget _handlePopupOrFull(
    BuildContext context,
    Widget contentScreen,
    Function retryActionFunction,
  ) {
    if (getStateRendererType().isPopup) {
      _dismissDialog(context);
      _showPopup(context, getStateRendererType(), getMessage());
      return contentScreen;
    } else {
      return StateRenderer(
        stateRendererType: getStateRendererType(),
        message: getMessage(),
        retryActionFunction: retryActionFunction,
      );
    }
  }

  void _dismissDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  void _showPopup(
    BuildContext context,
    StateRendererType stateRendererType,
    String message, {
    String title = Constants.empty,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          title: title,
          retryActionFunction: () {},
        ),
      );
    });
  }
}

extension on StateRendererType {
  bool get isPopup =>
      this == StateRendererType.popUpLoadingState ||
      this == StateRendererType.popUpErrorState ||
      this == StateRendererType.popUpSuccessState;
}

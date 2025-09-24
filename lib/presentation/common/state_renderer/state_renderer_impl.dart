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
// extension FlowStateExtension on FlowState {
//   // This method returns a widget based on the current state of the application.
//   Widget getStateWidget(BuildContext context, Widget contentScreen,
//       Function retryActionFunction) {
//     switch (this) // runtimeType returns the type of the object at runtime
//     {
//       case LoadingState _:
//         if (getStateRendererType() == StateRendererType.popUpLoadingState) {
//           showPopup(context, getStateRendererType(), getMessage());
//           return contentScreen;
//         } else {
//           return StateRenderer(
//             stateRendererType: getStateRendererType(),
//             message: getMessage(),
//             retryActionFunction: retryActionFunction,
//           );
//         }
//       case ErrorState _:
//         if (getStateRendererType() == StateRendererType.popUpErrorState) {
//           showPopup(context, getStateRendererType(), getMessage());
//           Navigator.pop(context);
//           return contentScreen;
//         } else {
//           return StateRenderer(
//             stateRendererType: getStateRendererType(),
//             message: getMessage(),
//             retryActionFunction: retryActionFunction,
//           );
//         }
//       case ContentState _:
//         dismissDialog(context);
//         return contentScreen;
//       case EmptyState _:
//         return StateRenderer(
//           stateRendererType: getStateRendererType(),
//           retryActionFunction: () {},
//           message: getMessage(),
//         );
//       case SuccessState _:
//         showPopup(context, getStateRendererType(), getMessage(),title: Strings.success);
//         Navigator.pop(context);
//         return contentScreen;
//       default:
//         dismissDialog(context);
//         return contentScreen;
//     }
//   }
//
//   bool _isCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;
//   // The function checks if there is a dialog (or modal route) currently active and visible in the navigation stack.
//   // If there is a dialog, it returns true; otherwise, it returns false.
//
//   void dismissDialog(BuildContext context) {
//     // This function dismisses the dialog if it is currently showing.
//     if (_isCurrentDialogShowing(context)) {
//       Navigator.of(context, rootNavigator: true).pop(true);
//     }
//   }
//
//   // rootNavigator: true is used to dismiss the dialog from the root of the widget tree, ensuring that it closes even if there are nested navigators.
//   showPopup(BuildContext context, StateRendererType stateRendererType,
//       String message, {String title = Constants.empty}) {
//     WidgetsBinding.instance.addPostFrameCallback(
//       // for executing code after the UI has been fully rendered
//           (_) => showDialog(
//         context: context,
//         builder: (BuildContext context) => StateRenderer(
//           stateRendererType: stateRendererType,
//           message: message,
//           title: title,
//           retryActionFunction: () {},
//         ),
//       ),
//     );
//   }
// }


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

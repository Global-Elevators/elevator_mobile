import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // POPUP STATES (DIALOG)
  popUpLoadingState,
  popUpErrorState,
  popUpSuccessState,
  // FULLSCREEN STATES (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  contentState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function
  retryActionFunction; // The function to call when the user retries an action

  const StateRenderer({
    super.key,
    required this.stateRendererType,
    this.message = Strings.loading,
    this.title = "",
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) =>
      _getStateWidget(stateRendererType, context);

  Widget _getStateWidget(
    StateRendererType stateRendererType,
    BuildContext context,
  ) {
    switch (stateRendererType) {
      case StateRendererType.popUpLoadingState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.loadingState),
        ]);
      case StateRendererType.popUpErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.errorState),
          _getMessage(message),
          _getRetryButton(Strings.ok, context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColum([
          _getAnimatedImage(JsonAssets.loadingState),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColum([
          _getAnimatedImage(JsonAssets.errorState),
          _getMessage(message),
          _getRetryButton(Strings.retryAgain, context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColum([
          _getAnimatedImage(JsonAssets.emptyState),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();
      case StateRendererType.popUpSuccessState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.successState),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(Strings.ok, context),
        ]);
    }
  }

  Column _getItemsColum(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  SizedBox _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Center _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSize.s8),
        child: Text(
          message,
          style: getRegularTextStyle(
            color: ColorManager.blackColor,
            fontSize: FontSizeManager.s18,
          ),
        ),
      ),
    );
  }

  Center _getRetryButton(String buttonTitle, context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSize.s18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
            ),
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                retryActionFunction.call();
              }
              else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              buttonTitle,
              style: getRegularTextStyle(
                color: ColorManager.whiteColor,
                fontSize: FontSizeManager.s18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Dialog _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Column _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}

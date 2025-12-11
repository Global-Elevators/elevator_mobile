import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/functions.dart';
import 'package:elevator/app/navigation_service.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/main/profile/change_password/change_password_view.dart';
import 'package:elevator/presentation/main/profile/contracts_status/contracts_status_view.dart';
import 'package:elevator/presentation/main/profile/edit_information/edit_information_view.dart';
import 'package:elevator/presentation/main/profile/help/help_view.dart';
import 'package:elevator/presentation/main/profile/profile_viewmodel.dart';
import 'package:elevator/presentation/main/profile/request_status/request_status_view.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/app_bar_label.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatefulWidget {
  static const String profileRoute = '/profile';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final NavigationService _navigationService = NavigationService(
    instance<AppPreferences>(),
  );
  late final List<ProfileItemWidget> _firstItems = [
    ProfileItemWidget(
      IconAssets.profile,
      Strings.editInformation.tr(),
      () => _navigationService.navigateWithAuthCheck(
        context: context,
        authenticatedRoute: EditInformationView.routeName,
      ),
    ),
    ProfileItemWidget(
      IconAssets.contractsStatus,
      Strings.contractsStatus.tr(),
      () => _navigationService.navigateWithAuthCheck(
        context: context,
        authenticatedRoute: ContractsStatusView.routeName,
      ),
    ),
    ProfileItemWidget(
      IconAssets.request,
      Strings.requestStatus.tr(),
      () => _navigationService.navigateWithAuthCheck(
        context: context,
        authenticatedRoute: RequestStatusView.routeName,
      ),
    ),
    ProfileItemWidget(
      IconAssets.passwordIconField,
      Strings.changePassword.tr(),
      () => _navigationService.navigateWithAuthCheck(
        context: context,
        authenticatedRoute: ChangePasswordView.routeName,
      ),
    ),
    ProfileItemWidget(
      IconAssets.language,
      Strings.language.tr(),
      () => _showDialogWidget(
        context,
        image: IconAssets.coverLanguage,
        title: Strings.changeLanguage.tr(),
      ),
    ),
  ];

  late final List<ProfileItemWidget> _secondItems = [
    ProfileItemWidget(
      IconAssets.warning,
      Strings.help.tr(),
      () => context.push(HelpView.routeName),
    ),
    ProfileItemWidget(
      IconAssets.signOut,
      Strings.signOut.tr(),
      () => _showDialogWidget(
        context,
        image: IconAssets.coverSignOut,
        title: Strings.signOut.tr(),
        description: Strings.signOutDescription.tr(),
      ),
    ),
  ];

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final ProfileViewModel _viewModel = instance<ProfileViewModel>();
  StreamSubscription<bool>? _logoutSubscription;

  @override
  void initState() {
    super.initState();
    _viewModel.start();
    _logoutSubscription = _viewModel.outLogoutSuccess.listen((success) {
      if (success && mounted) context.go(LoginView.loginRoute);
    });
  }

  @override
  void dispose() {
    _logoutSubscription?.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final content = SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
            child: Column(
              children: [
                AppBarLabel(Strings.profile.tr()),
                Gap(AppSize.s40.h),
                _buildProfileList(_firstItems),
                Gap(AppSize.s50.h),
                _buildProfileList(_secondItems),
              ],
            ),
          ),
        );

        return state?.getStateWidget(context, content, () {}) ?? content;
      },
    );
  }

  Widget _buildProfileList(List<ProfileItemWidget> items) =>
      Column(children: items);

  void _showDialogWidget(
    BuildContext context, {
    required String image,
    required String title,
    String? description,
  }) {
    final currentLanguage = context.locale.languageCode;
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          height: AppSize.s270.h,
          padding: EdgeInsets.all(AppPadding.p16.r),
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s30.r),
            boxShadow: const [BoxShadow(color: Colors.black26)],
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                image,
                height: AppSize.s100.h,
                width: AppSize.s100.w,
              ),
              Gap(AppSize.s16.h),
              Text(
                title,
                style: getBoldTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s22.sp,
                ),
              ),
              if (description != null && description.isNotEmpty) ...[
                Gap(AppSize.s4.h),
                Text(
                  description,
                  style: getMediumTextStyle(
                    color: ColorManager.greyColor,
                    fontSize: FontSizeManager.s16.sp,
                  ),
                ),
              ],
              const Spacer(),
              dialogButtons(title, context, currentLanguage),
            ],
          ),
        ),
      ),
    );
  }

  Row dialogButtons(
    String title,
    BuildContext context,
    String currentLanguage,
  ) {
    return Row(
      children: [
        dialogFirstButton(title, context, currentLanguage),
        dialogSecondButton(title, context, currentLanguage),
      ],
    );
  }

  // Change to arabic or sign out
  Expanded dialogSecondButton(
    String title,
    BuildContext context,
    String currentLanguage,
  ) {
    return Expanded(
      child: ButtonWidget(
        radius: AppSize.s14,
        text: title == Strings.changeLanguage.tr()
            ? Strings.arabicText.tr()
            : Strings.signOut.tr(),
        color: title == Strings.signOut.tr()
            ? ColorManager.whiteColor
            : currentLanguage == 'ar'
            ? ColorManager.primaryColor
            : ColorManager.whiteColor,
        textColor: title == Strings.signOut.tr()
            ? ColorManager.errorColor
            : currentLanguage == 'ar'
            ? ColorManager.whiteColor
            : ColorManager.primaryColor,
        onTap: () async {
          if (title == Strings.changeLanguage.tr()) {
            if (currentLanguage == 'en') {
              changeLanguage(context);
            } else {
              Navigator.pop(context);
            }
          } else {
            final isUserLoggedIn = _appPreferences.isUserLoggedIn("login");
            if (await isUserLoggedIn) return _viewModel.signOut();
            return context.go(LoginView.loginRoute);
          }
        },
      ),
    );
  }

  // Change to english or cancel
  Expanded dialogFirstButton(
    String title,
    BuildContext context,
    String currentLanguage,
  ) {
    return Expanded(
      child: ButtonWidget(
        color: currentLanguage == 'en'
            ? ColorManager.primaryColor
            : ColorManager.whiteColor,
        textColor: currentLanguage == 'en'
            ? ColorManager.whiteColor
            : ColorManager.primaryColor,
        radius: AppSize.s14,
        text: title == Strings.changeLanguage.tr()
            ? Strings.englishText.tr()
            : Strings.cancel.tr(),
        onTap: () async {
          if (title == Strings.changeLanguage.tr()) {
            if (currentLanguage == 'ar') {
              changeLanguage(context);
            } else {
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class ProfileItemWidget extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback? onTap;

  const ProfileItemWidget(this.image, this.text, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.s12.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.s99.r),
        onTap: onTap,
        child: Container(
          height: AppSize.s70.h,
          decoration: BoxDecoration(
            color: const Color(0XFFFAFBFB),
            borderRadius: BorderRadius.circular(AppSize.s99.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.s16.w,
            vertical: AppSize.s22.h,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                height: AppSize.s28.h,
                width: AppSize.s28.w,
              ),
              Gap(AppSize.s14.w),
              Text(
                text,
                style: getMediumTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s22.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

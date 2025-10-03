import 'package:elevator/presentation/main/profile/change_password/change_password_view.dart';
import 'package:elevator/presentation/main/profile/contracts_status/contracts_status_view.dart';
import 'package:elevator/presentation/main/profile/edit_information/edit_information_view.dart';
import 'package:elevator/presentation/main/profile/help/help_view.dart';
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
  late final List<ProfileItemWidget> _firstItems = [
    ProfileItemWidget(
      IconAssets.profile,
      Strings.editInformation,
          () => context.push(EditInformationView.routeName),
    ),
    ProfileItemWidget(
      IconAssets.contractsStatus,
      Strings.contractsStatus,
          () => context.push(ContractsStatusView.routeName),
    ),
    ProfileItemWidget(
      IconAssets.request,
      Strings.requestStatus,
          () => context.push(RequestStatusView.routeName),
    ),
    ProfileItemWidget(
      IconAssets.passwordIconField,
      Strings.changePassword,
          () => context.push(ChangePasswordView.routeName),
    ),
    ProfileItemWidget(
      IconAssets.language,
      Strings.language,
          () => _showDialogWidget(
        context,
        image: IconAssets.coverLanguage,
        title: Strings.changeLanguage,
      ),
    ),
  ];

  late final List<ProfileItemWidget> _secondItems = [
    ProfileItemWidget(
      IconAssets.warning,
      Strings.help,
          () => context.push(HelpView.routeName),
    ),
    ProfileItemWidget(
      IconAssets.signOut,
      Strings.signOut,
          () => _showDialogWidget(
        context,
        image: IconAssets.coverSignOut,
        title: Strings.signOut,
        description: Strings.signOutDescription,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
        child: Column(
          children: [
            AppBarLabel(Strings.profile),
            Gap(AppSize.s45.h),
            _buildProfileList(_firstItems),
            Gap(AppSize.s50.h),
            _buildProfileList(_secondItems),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileList(List<ProfileItemWidget> items) => Column(children: items);

  void _showDialogWidget(
      BuildContext context, {
        required String image,
        required String title,
        String? description,
      }) {
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
              SvgPicture.asset(image, height: AppSize.s100.h, width: AppSize.s100.w),
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
              Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      radius: AppSize.s14,
                      text: title == Strings.changeLanguage
                          ? Strings.englishText
                          : Strings.cancel,
                      onTap: () => title == Strings.changeLanguage
                          ? null // TODO: change language to English or back to arabic
                          : Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: ButtonWidget(
                      radius: AppSize.s14,
                      text: title == Strings.changeLanguage
                          ? Strings.arabicText
                          : Strings.signOut,
                      color: ColorManager.whiteColor,
                      textColor: title == Strings.changeLanguage
                          ? ColorManager.primaryColor
                          : ColorManager.errorColor,
                      onTap: () => title == Strings.changeLanguage
                          ? null // TODO: change language to Arabic
                          : null, // TODO: sign out logic
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
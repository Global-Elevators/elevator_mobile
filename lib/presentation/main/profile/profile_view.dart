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
import 'package:elevator/presentation/widgets/text_button_widget.dart';
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
  late List<ProfileItemWidget> firstItems = [
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
      () => showDialog(
        context: context,
        builder: (BuildContext context) => showLanguageDialog(context),
      ),
    ),
  ];

  late List<ProfileItemWidget> secondItems = [
    ProfileItemWidget(
      IconAssets.warning,
      Strings.help,
      () => context.push(HelpView.routeName),
    ),
    ProfileItemWidget(
      IconAssets.signOut,
      Strings.signOut,
      () => showDialog(
        context: context,
        builder: (BuildContext context) => showSignOutDialog(context),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: AppSize.s16.w),
          child: Column(
            children: [
              AppBarLabel(Strings.profile),
              Gap(AppSize.s45.h),
              ...firstItems,
              Gap(AppSize.s50.h),
              ...secondItems,
            ],
          ),
        ),
      ),
    );
  }

  showSignOutDialog(context) => Dialog(
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
      child: Container(
        height: AppSize.s270.h,
        width: double.infinity.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s30.r),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        padding: EdgeInsetsDirectional.all(AppPadding.p16.r),
        child: Column(
          children: [
            SvgPicture.asset(
              IconAssets.coverSignOut,
              height: AppSize.s100.h,
              width: AppSize.s100.w,
            ),
            Gap(AppSize.s16.h),
            Text(
              Strings.signOut,
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s22.sp,
              ),
            ),
            Gap(AppSize.s4.h),
            Text(
              Strings.signOutDescription,
              style: getMediumTextStyle(
                color: ColorManager.greyColor,
                fontSize: FontSizeManager.s16.sp,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    radius: AppSize.s14,
                    text: Strings.cancel,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: TextButtonWidget(
                    Strings.signOut,
                    ColorManager.errorColor,
                    FontSizeManager.s18,
                    () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  showLanguageDialog(context) => Dialog(
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
      child: Container(
        height: AppSize.s270.h,
        width: double.infinity.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s30.r),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        padding: EdgeInsetsDirectional.all(AppPadding.p16.r),
        child: Column(
          children: [
            SvgPicture.asset(
              IconAssets.coverLanguage,
              height: AppSize.s100.h,
              width: AppSize.s100.w,
            ),
            Gap(AppSize.s16.h),
            Text(
              Strings.changeLanguage,
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s22.sp,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    radius: AppSize.s14,
                    text: Strings.cancel,
                    onTap: () {},
                    color: ColorManager.primaryColor,
                    textColor: ColorManager.whiteColor,
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    radius: AppSize.s14,
                    text: Strings.arabicText,
                    onTap: () {},
                    color: ColorManager.whiteColor,
                    textColor: ColorManager.primaryColor,
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

class ProfileItemWidget extends StatelessWidget {
  final String image;
  final String text;
  final void Function()? onTap;

  const ProfileItemWidget(this.image, this.text, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: AppSize.s70.h,
            decoration: BoxDecoration(
              color: Color(0XFFFAFBFB),
              borderRadius: BorderRadius.circular(AppSize.s99.r),
            ),
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: AppSize.s16.w,
              vertical: AppSize.s22.h,
            ),
            child: Row(
              children: [itemIcon(image), Gap(AppSize.s14.w), itemText(text)],
            ),
          ),
        ),
        Gap(AppSize.s12.h),
      ],
    );
  }

  Text itemText(String text) {
    return Text(
      text,
      style: getMediumTextStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s22.sp,
      ),
    );
  }

  SvgPicture itemIcon(String image) =>
      SvgPicture.asset(image, height: AppSize.s28.h, width: AppSize.s28.w);
}

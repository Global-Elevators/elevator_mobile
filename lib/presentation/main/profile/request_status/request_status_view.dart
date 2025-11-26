import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class RequestStatusView extends StatefulWidget {
  static const String routeName = '/request-status';

  const RequestStatusView({super.key});

  @override
  State<RequestStatusView> createState() => _RequestStatusViewState();
}

class _RequestStatusViewState extends State<RequestStatusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: Strings.requestStatus.tr()),
      // body: Padding(
      //   padding: EdgeInsetsDirectional.all(AppPadding.p16),
      //   child: Column(
      //     children: [
      //       _buildRequestItem(
      //         title: "Request site survey",
      //         dateTime: "08/12/2025 - 03:42 PM",
      //         status: "Pending",
      //         onEdit: () {},
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // Widget _buildRequestItem({
  //   required String title,
  //   required String dateTime,
  //   required String status,
  //   required VoidCallback onEdit,
  //   required VoidCallback onTap,
  // }) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsetsDirectional.all(AppPadding.p12),
  //       decoration: BoxDecoration(
  //         color: ColorManager.whiteColor,
  //         borderRadius: BorderRadius.circular(AppSize.s12.r),
  //         border: Border.all(color: ColorManager.buttonsBorderColor),
  //       ),
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               SvgPicture.asset(
  //                 IconAssets.request,
  //                 height: AppSize.s20.h,
  //                 width: AppSize.s20.w,
  //               ),
  //               Gap(AppSize.s5.w),
  //               Text(
  //                 Strings.requestSiteSurvey.tr(),
  //                 style: getMediumTextStyle(
  //                   color: ColorManager.primaryColor,
  //                   fontSize: FontSizeManager.s16.sp,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Gap(AppSize.s20.h),
  //           Row(
  //             children: [
  //               Text(
  //                 "08/12/2025 - 03:42 PM",
  //                 style: getMediumTextStyle(
  //                   color: ColorManager.greyColor,
  //                   fontSize: FontSizeManager.s14,
  //                 ),
  //               ),
  //               const Spacer(),
  //               ButtonWidget(
  //                 radius: AppSize.s99.r,
  //                 text: Strings.edit.tr(),
  //                 color: Color(0xffC8C8C8),
  //               ),
  //               Gap(AppSize.s8.w),
  //               ButtonWidget(
  //                 width: 80,
  //                 height: 31,
  //                 radius: AppSize.s99.r,
  //                 text: Strings.pending.tr(),
  //                 color: Color(0xffFF9408),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

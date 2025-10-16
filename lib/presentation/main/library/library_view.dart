import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/app_bar_label.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LibraryView extends StatefulWidget {
  static const String libraryRoute = '/library';

  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarLabel(Strings.documents.tr()),
            Gap(AppSize.s24.h),
            _documentsRow(),
          ],
        ),
      ),
    );
  }

  _documentsRow() => Column(
    children: [
      repairAndNewProductButtons(),
      Gap(AppSize.s12.h),
      annualPreventiveMaintenanceButton(),
    ],
  );

  SizedBox annualPreventiveMaintenanceButton() {
    return SizedBox(
      height: AppSize.s45.h,
      child: ButtonWidget(
        radius: AppSize.s99.r,
        text: Strings.annualPreventiveMaintenance.tr(),
        onTap: () {
          setState(() => selectedIndex = 2);
        },
        color: selectedIndex == 2
            ? ColorManager.primaryColor
            : Color(0xffF5F5F5),
        textColor: selectedIndex == 2
            ? ColorManager.whiteColor
            : ColorManager.primaryColor,
      ),
    );
  }

  Row repairAndNewProductButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: AppSize.s8.w,
      children: List.generate(2, (index) {
        return Expanded(
          child: SizedBox(
            height: AppSize.s45.h,
            child: ButtonWidget(
              radius: AppSize.s99.r,
              text: index == 0 ? Strings.repair.tr() : Strings.newProduct.tr(),
              onTap: () {
                setState(() => selectedIndex = index);
              },
              color: selectedIndex == index
                  ? ColorManager.primaryColor
                  : Color(0xffF5F5F5),
              textColor: selectedIndex == index
                  ? ColorManager.whiteColor
                  : ColorManager.primaryColor,
            ),
          ),
        );
      }),
    );
  }
}

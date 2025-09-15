import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DropdownScope extends StatelessWidget {
  final DropdownController<String> controller;
  final String? selectedValue;
  final ValueChanged<String> onChangedItem;

  const DropdownScope({
    super.key,
    required this.controller,
    this.selectedValue,
    required this.onChangedItem,
  });

  @override
  Widget build(BuildContext context) {
    String singleSelection = selectedValue ?? "";
    return SimpleDropdown<String>.list(
      controller: controller,
      builder: (_) => Container(
        height: AppSize.s55.h,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.formFieldsBorderColor),
          borderRadius: BorderRadius.circular(AppSize.s14.r),
          color: ColorManager.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppPadding.p12,
          ),
          child: Row(
            children: [
              Text(
                singleSelection.isNotEmpty ? singleSelection : "Select",
                style: getRegularTextStyle(
                  color: ColorManager.greyColor,
                  fontSize: FontSizeManager.s18,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.keyboard_arrow_down,
                size: AppSize.s30,
                color: ColorManager.primaryColor,
              ),
            ],
          ),
        ),
      ),
      menuPosition: DropdownMenuPosition(offset: Offset(0, AppSize.s18.h)),
      itemBuilder: (_, item) {
        return GestureDetector(
          onTap: () {
            controller.select(item.value, dismiss: true);
            onChangedItem(item.value);
            controller.dismiss();
          },
          child: Container(
            width: double.infinity,
            height: AppSize.s55.h,
            decoration: BoxDecoration(
              color: item.selected
                  ? ColorManager.primaryColor
                  : ColorManager.buttonsBorderColor,
              borderRadius: BorderRadius.circular(AppSize.s12.r),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppPadding.p12,
                top: AppPadding.p18,
                bottom: AppPadding.p18,
              ),
              child: Text(
                item.value,
                style: getRegularTextStyle(
                  color: item.selected
                      ? ColorManager.whiteColor
                      : ColorManager.greyColor,
                  fontSize: FontSizeManager.s16,
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Gap(AppSize.s8.h),
    );
  }
}



import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemsDropDown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final String hintText;
  final void Function(String?) onChanged;

  const ItemsDropDown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: const PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 8,
        color: Colors.white,
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        offset: Offset(0, 56.h),
        // This is the magic: force menu width = trigger width
        constraints: const BoxConstraints(minWidth: double.infinity),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          side: BorderSide(color: ColorManager.buttonsBorderColor, width: 1.5),
        ),

        itemBuilder: (context) => items
            .map(
              (item) => PopupMenuItem(
                value: item,
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item,
                    style: getMediumTextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: AppSize.s18.sp,
                    ),
                  ),
                ),
              ),
            )
            .toList(),

        onSelected: onChanged,

        child: Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppSize.s12.r),
            border: Border.all(
              color: ColorManager.buttonsBorderColor,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedItem ?? hintText,
                  style: getMediumTextStyle(
                    color: selectedItem != null
                        ? ColorManager.primaryColor
                        : ColorManager.greyColor,
                    fontSize: AppSize.s18.sp,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ColorManager.primaryColor,
                size: 28.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

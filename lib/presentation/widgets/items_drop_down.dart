import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemsDropDown extends StatefulWidget {
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
  State<ItemsDropDown> createState() => _ItemsDropDownState();
}

class _ItemsDropDownState extends State<ItemsDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s55.h,
      padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(
          color: ColorManager.formFieldsBorderColor,
          width: AppSize.s1.w,
        ),
      ),
      child: DropdownButton(
        underline: SizedBox.shrink(),
        hint: Text(widget.hintText),
        isExpanded: true,
        style: getMediumTextStyle(
          color: ColorManager.primaryColor,
          fontSize: AppSize.s18.sp,
        ),
        value: widget.selectedItem,
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        items: widget.items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}

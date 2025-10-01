import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/items_drop_down.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LabelDropDownWidget extends StatelessWidget {
  final String title;
  final List<String> dropDownItems;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final bool isOptional;

  const LabelDropDownWidget({
    super.key,
    required this.title,
    required this.dropDownItems,
    required this.selectedValue,
    required this.onChanged,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(title, isOptional: isOptional),
        Gap(AppSize.s8.h),
        buildItemsDropDown(dropDownItems, selectedValue, onChanged),
      ],
    );
  }

  ItemsDropDown buildItemsDropDown(
    List<String> items,
    String? selectedItem,
    void Function(String?) onChanged,
  ) {
    return ItemsDropDown(
      items: items,
      hintText: Strings.selectOne,
      onChanged: onChanged,
      selectedItem: selectedItem,
    );
  }
}

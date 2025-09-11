import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressDropDown extends StatefulWidget {
  const AddressDropDown({super.key});

  @override
  State<AddressDropDown> createState() => _AddressDropDownState();
}

class _AddressDropDownState extends State<AddressDropDown> {
  final List<String> addresses = ["Cairo", "Alexandria", "Giza", "Mansoura"];
  String? selectedAddress;

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
        hint: Text("Select your address"),
        isExpanded: true,
        style: getMediumTextStyle(
          color: ColorManager.primaryColor,
          fontSize: AppSize.s18.sp,
        ),
        value: selectedAddress,
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        items: addresses
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedAddress = value;
          });
        },
      ),
    );
  }
}

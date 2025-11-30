import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BuildNameSection extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController fatherNameController;
  final TextEditingController grandFatherNameController;
  final Stream<bool>? nameStream;
  final Stream<bool>? fatherNameStream;
  final Stream<bool>? grandFatherNameStream;

  const BuildNameSection({
    super.key,
    required this.firstNameController,
    required this.fatherNameController,
    required this.grandFatherNameController,
    this.nameStream,
    this.fatherNameStream,
    this.grandFatherNameStream,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.nameLabel.tr()),
        Gap(AppSize.s8.h),
        StreamBuilder<bool>(
          stream: nameStream,
          builder: (context, snapshot) => TextFromFieldWidget(
            hintText: Strings.firstName.tr(),
            controller: firstNameController,
            prefixIcon: Icon(
              Icons.account_circle_outlined,
              size: AppSize.s30,
              color: ColorManager.primaryColor,
            ),
            errorText: (snapshot.data ?? true)
                ? null
                : Strings.invalidName.tr(),
          ),
        ),
        Gap(AppSize.s8.h),
        Row(
          children: [
            StreamBuilder<bool>(
              stream: fatherNameStream,
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                      Expanded(
                        child: TextFromFieldWidget(
                          hintText: Strings.fatherName.tr(),
                          controller: fatherNameController,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : Strings.invalidName.tr(),
                        ),
                      ),
            ),
            Gap(AppSize.s8.w),
            StreamBuilder<bool>(
              stream: grandFatherNameStream,
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                      Expanded(
                        child: TextFromFieldWidget(
                          hintText: Strings.grandfatherName.tr(),
                          controller: grandFatherNameController,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : Strings.invalidName.tr(),
                        ),
                      ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatelessWidget {
  final File? singleImage;
  final List<XFile>? multipleImages;
  final bool isMultiple;
  final VoidCallback onTap;
  final String placeholderText;

  const CustomImagePicker({
    super.key,
    this.singleImage,
    this.multipleImages,
    this.isMultiple = false,
    required this.onTap,
    required this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.photos, isOptional: isMultiple),
        Gap(AppSize.s8.h),
        InkWell(
          onTap: onTap,
          child: Container(
            height: AppSize.s100.h,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(AppSize.s12.r),
            ),
            child: DottedBorder(
              options: RectDottedBorderOptions(
                dashPattern: [6, 6],
                color: ColorManager.formFieldsBorderColor,
                strokeWidth: AppSize.s2,
              ),
              child: Center(child: _buildContent()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (isMultiple) {
      if (multipleImages == null || multipleImages!.isEmpty) {
        return _emptyPlaceholder();
      }
      return Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: AppSize.s16.w,
          ),
          child: GridView.builder(
            itemCount: multipleImages!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: Image.file(
                      File(multipleImages![index].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gap(AppSize.s8.w),
                ],
              );
            },
          ),
        ),
      );
    } else {
      if (singleImage == null) {
        return _emptyPlaceholder();
      }
      return Image.file(singleImage!, fit: BoxFit.cover);
    }
  }

  Widget _emptyPlaceholder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(IconAssets.file),
        Gap(AppSize.s5.w),
        Text(
          placeholderText,
          style: getRegularTextStyle(
            color: ColorManager.greyColor,
            fontSize: FontSizeManager.s16.sp,
          ),
        ),
      ],
    );
  }
}

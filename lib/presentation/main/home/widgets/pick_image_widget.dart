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

class PickImageWidget extends StatelessWidget {
  final Function() pickImageFromGallery;
  final File? imageFile;

  const PickImageWidget({
    super.key,
    required this.pickImageFromGallery,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickImageFromGallery(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelField(Strings.photos, isOptional: true),
          Gap(AppSize.s8.h),
          Container(
            height: AppSize.s100.h,
            width: double.infinity.w,
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
              child: Center(
                child: imageFile == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.file),
                          Gap(AppSize.s5.w),
                          Text(
                            Strings.shaftPhoto2BuildingFrontPhoto1,
                            style: getRegularTextStyle(
                              color: ColorManager.greyColor,
                              fontSize: FontSizeManager.s16.sp,
                            ),
                          ),
                        ],
                      )
                    : Image.file(imageFile!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

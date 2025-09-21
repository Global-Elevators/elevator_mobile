import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final double radius, width;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color textColor;
  final Stream<bool>? isButtonEnabledStream;

  const ButtonWidget({
    super.key,
    required this.radius,
    this.width = double.infinity,
    this.color = ColorManager.primaryColor,
    required this.text,
    this.onTap,
    this.textColor = ColorManager.whiteColor,
    this.isButtonEnabledStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isButtonEnabledStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        final bool isEnabled = (snapshot.data ?? false) && onTap != null;

        return InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(radius.r),
          splashColor: isEnabled ? null : Colors.transparent,
          highlightColor: isEnabled ? null : Colors.transparent,
          child: Container(
            height: AppSize.s55.h,
            width: width.w,
            decoration: BoxDecoration(
              color: isEnabled ? color : ColorManager.greyColor,
              borderRadius: BorderRadius.circular(radius.r),
              border: Border.all(
                color: ColorManager.formFieldsBorderColor,
                width: AppSize.s1.w,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: getMediumTextStyle(
                  color: isEnabled
                      ? textColor
                      : ColorManager.whiteColor.withValues(
                          alpha: 0.7,
                        ),
                  fontSize: AppSize.s18.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/main/home/widgets/label_text_form_field_widget.dart';
import 'package:elevator/presentation/main/home/widgets/label_yes_or_no_widget.dart';
import 'package:elevator/presentation/main/home/widgets/pick_image_widget.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:elevator/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ReportBreakDownView extends StatefulWidget {
  static const String reportBreakDownRoute = "/reportBreakDownRoute";

  const ReportBreakDownView({super.key});

  @override
  State<ReportBreakDownView> createState() => _ReportBreakDownViewState();
}

class _ReportBreakDownViewState extends State<ReportBreakDownView> {
  bool anyBodyInjuredOrTrappedInsideTheElevator = false;
  File? _imageFile;
  final TextEditingController _descriptionOfBreakDownController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Strings.reportBreakDown,
        showBackButton: true,
        popOrGo: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p16.w),
        child: Column(
          children: [
            LabelYesOrNoWidget(
              title: Strings.anyBodyInjuredOrTrappedInsideTheElevator,
              condition: anyBodyInjuredOrTrappedInsideTheElevator,
              onYesTap: () => setState(
                () => anyBodyInjuredOrTrappedInsideTheElevator = false,
              ),
              onNoTap: () => setState(
                () => anyBodyInjuredOrTrappedInsideTheElevator = true,
              ),
            ),
            Gap(AppSize.s25.h),
            CustomImagePicker(
              singleImage: _imageFile,
              onTap: () => _pickImageFromGallery(),
              placeholderText: Strings.filePhotoOrVideo,
            ),
            Gap(AppSize.s25.h),
            LabelTextFormFieldWidget(
              title: Strings.descriptionOfBreakDown,
              hintText: 'Description here !',
              controller: _descriptionOfBreakDownController,
              isOptional: true,
              isNotes: true,
              isCenterText: true,
            ),
            Gap(AppSize.s25.h),
            ButtonWidget(
              radius: AppSize.s14.r,
              text: Strings.report,
              onTap: () => CustomBottomSheet.show(
                context: context,
                imagePath: ImageAssets.successfully,
                message: Strings.yourRequestHadBeenRecorded,
                buttonText: Strings.done,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      debugPrint('No image selected.');
    }
  }
}

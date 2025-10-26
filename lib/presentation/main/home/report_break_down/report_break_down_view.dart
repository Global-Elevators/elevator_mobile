import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/report_break_down/report_break_down_viewmodel.dart';
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
  final ReportBreakDownViewmodel viewmodel =
      instance<ReportBreakDownViewmodel>();
  bool anyBodyInjuredOrTrappedInsideTheElevator = false;
  File? _imageFile;
  final TextEditingController _descriptionOfBreakDownController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    viewmodel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Strings.reportBreakDown.tr(),
        showBackButton: true,
        popOrGo: true,
      ),
      body: StreamBuilder<FlowState>(
        stream: viewmodel.outputStateStream,
        builder: (context, snapshot) {
          return snapshot.data?.getStateWidget(
                context,
                _getContentWidget(context),
                () {},
              ) ??
              _getContentWidget(context);
        },
      ),
    );
  }

  Padding _getContentWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p16.w),
      child: Column(
        children: [
          LabelYesOrNoWidget(
            title: Strings.anyBodyInjuredOrTrappedInsideTheElevator.tr(),
            condition: anyBodyInjuredOrTrappedInsideTheElevator,
            onYesTap: () => setState(
              () => anyBodyInjuredOrTrappedInsideTheElevator = false,
            ),
            onNoTap: () =>
                setState(() => anyBodyInjuredOrTrappedInsideTheElevator = true),
          ),
          Gap(AppSize.s25.h),
          CustomImagePicker(
            singleImage: _imageFile,
            onTap: _pickImageFromGallery,
            placeholderText: Strings.filePhotoOrVideo.tr(),
            isImageLoading: viewmodel.showLoading,
          ),
          Gap(AppSize.s25.h),
          LabelTextFormFieldWidget(
            title: Strings.descriptionOfBreakDown.tr(),
            hintText: Strings.descriptionOfBreakDown.tr(),
            controller: _descriptionOfBreakDownController,
            isOptional: true,
            isNotes: true,
            isCenterText: true,
            isButtonEnabledStream: null,
          ),
          Gap(AppSize.s25.h),
          ButtonWidget(
            radius: AppSize.s14.r,
            text: Strings.report.tr(),
            onTap: () => CustomBottomSheet.show(
              context: context,
              imagePath: ImageAssets.successfully,
              message: Strings.yourRequestHadBeenRecorded.tr(),
              buttonText: Strings.done.tr(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _imageFile = File(picked.path));
    viewmodel.setImageFile(_imageFile);
  }
}

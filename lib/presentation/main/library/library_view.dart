import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/library/library_viewmodel.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/app_bar_label.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ============================================
// 1. LibraryView - Main Widget
// ============================================
class LibraryView extends StatefulWidget {
  static const String libraryRoute = '/library';

  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  int selectedIndex = 0;
  final viewmodel = instance<LibraryViewModel>();

  @override
  void initState() {
    super.initState();
    viewmodel.start();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarLabel(Strings.documents.tr()),
            Gap(AppSize.s24.h),
            _DocumentCategoryButtons(
              selectedIndex: selectedIndex,
              onCategorySelected: (index) =>
                  setState(() => selectedIndex = index),
            ),
            Gap(AppSize.s24.h),
            Expanded(
              child: StreamBuilder<FlowState>(
                initialData: LoadingState(
                  stateRendererType: StateRendererType.fullScreenLoadingState,
                ),
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(BuildContext context) {
    final data = viewmodel.libraryAttachment?.data ?? [];

    // Map index to type
    final Map<int, String> categories = {
      0: 'repair',
      1: 'new_product',
      2: 'maintenance',
    };
    final selectedType = categories[selectedIndex];

    // Filter attachments by type
    final attachments = data
        .where((d) => d.type == selectedType)
        .expand((d) => d.attachments ?? [])
        .toList();

    return ListView.separated(
      itemCount: attachments.length,
      separatorBuilder: (_, __) => Gap(AppSize.s12.h),
      itemBuilder: (_, index) {
        final attachment = attachments[index];
        return _PdfDocumentItem(
          onView: () => _PdfDialogHelper.show(context, attachment.url),
          onDownload: () => _PdfDownloadHelper(
            context,
          ).downloadAndOpenPdf(attachment.url, attachment.name),
          documentName: attachment.name,
        );
      },
    );
  }
}

// ============================================
// 2. DocumentCategoryButtons - Category Selection UI
// ============================================
class _DocumentCategoryButtons extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const _DocumentCategoryButtons({
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: AppSize.s8.w,
          children: List.generate(2, (index) {
            return Expanded(
              child: _CategoryButton(
                text: index == 0
                    ? Strings.repair.tr()
                    : Strings.newProduct.tr(),
                isSelected: selectedIndex == index,
                onTap: () => onCategorySelected(index),
              ),
            );
          }),
        ),
        Gap(AppSize.s12.h),
        _CategoryButton(
          text: Strings.annualPreventiveMaintenance.tr(),
          isSelected: selectedIndex == 2,
          onTap: () => onCategorySelected(2),
        ),
      ],
    );
  }
}

// ============================================
// 3. CategoryButton - Reusable Button Component
// ============================================
class _CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s45.h,
      child: ButtonWidget(
        radius: AppSize.s99.r,
        text: text,
        onTap: onTap,
        color: isSelected ? ColorManager.primaryColor : const Color(0xffF5F5F5),
        textColor: isSelected
            ? ColorManager.whiteColor
            : ColorManager.primaryColor,
      ),
    );
  }
}

class _PdfDocumentItem extends StatelessWidget {
  final VoidCallback onView;
  final VoidCallback onDownload;
  final String documentName; // <-- add this

  const _PdfDocumentItem({
    required this.onView,
    required this.onDownload,
    required this.documentName, // <-- add this
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onView,
      child: Container(
        padding: EdgeInsets.only(left: AppPadding.p8.w),
        decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(AppSize.s12.r),
        ),
        child: Row(
          children: [
            Image.asset(IconAssets.pdf),
            Gap(AppSize.s8.w),
            Expanded(
              child: Text(
                documentName, // <-- use the actual doc name here
                style: getMediumTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s18.sp,
                ),
              ),
            ),
            _PdfDownloadButton(onTap: onDownload),
          ],
        ),
      ),
    );
  }
}

// ============================================
// 5. PdfDownloadButton - Download Button Component
// ============================================
class _PdfDownloadButton extends StatelessWidget {
  final VoidCallback onTap;

  const _PdfDownloadButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p12.w,
          vertical: AppPadding.p8.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xfff3f4f9),
          borderRadius: BorderRadius.circular(AppSize.s12.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p8.w,
            vertical: AppPadding.p12.h,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffDADCE2),
            borderRadius: BorderRadius.circular(AppSize.s8.r),
          ),
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              SvgPicture.asset(
                IconAssets.download,
                colorFilter: ColorFilter.mode(
                  ColorManager.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              Gap(AppSize.s5.w),
              Text(
                Strings.download.tr(),
                style: getBoldTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// 6. PdfDialogHelper - PDF Viewer Dialog
// ============================================
class _PdfDialogHelper {
  static void show(BuildContext context, String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, size: AppSize.s24.h),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(child: SfPdfViewer.network(url)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// 7. PdfDownloadHelper - Download + Open PDF
// ============================================
class _PdfDownloadHelper {
  final BuildContext context;

  _PdfDownloadHelper(this.context);

  Future<void> downloadAndOpenPdf(String url, String fileName) async {
    _showLoadingDialog();

    try {
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        _hideLoadingDialog();
        _showError("Storage permission denied");
        return;
      }

      final savePath = await _downloadFile(url, fileName);
      await _openFile(savePath);
      _hideLoadingDialog();
      _showSuccess("Downloaded and opened:\n$fileName");
    } on DioException catch (e) {
      _hideLoadingDialog();
      _showError("Download failed: ${e.message}");
    } catch (e) {
      _hideLoadingDialog();
      _showError("Download failed: $e");
    }
  }

  Future<String> _downloadFile(String url, String fileName) async {
    final downloadsDir = await _getDownloadsDirectory();
    final safeName = fileName.endsWith('.pdf') ? fileName : '$fileName.pdf';
    final savePath = "${downloadsDir.path}/$safeName";
    await Dio().download(
      url,
      savePath,
      options: Options(responseType: ResponseType.bytes),
    );
    final file = File(savePath);
    if (!await file.exists()) {
      throw FileSystemException("File not saved", savePath);
    }
    return savePath;
  }

  Future<Directory> _getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      final dirs = await getExternalStorageDirectories(
        type: StorageDirectory.downloads,
      );
      if (dirs != null && dirs.isNotEmpty) return dirs.first;
      return Directory('/storage/emulated/0/Download');
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<void> _openFile(String filePath) async => OpenFilex.open(filePath);

  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid) return true;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) return true;
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  void _showLoadingDialog() => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  void _hideLoadingDialog() {
    if (context.mounted) Navigator.pop(context);
  }

  void _showSuccess(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ $message"), backgroundColor: Colors.green),
    );
  }

  void _showError(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ $message"), backgroundColor: Colors.red),
    );
  }
}

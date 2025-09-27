import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class CatalogueView extends StatefulWidget {
  static const String catalogueRoute = '/catalogue';

  const CatalogueView({super.key});

  @override
  State<CatalogueView> createState() => _CatalogueViewState();
}

class _CatalogueViewState extends State<CatalogueView> {
  final PdfViewerController pdfViewerController = PdfViewerController();
  final TextEditingController controller = TextEditingController();

  double zoom = 0.0;
  int pageNo = 0;

  void _jumpTo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _JumpToPageDialog(
        controller: controller,
        onConfirm: (page) {
          pdfViewerController.jumpToPage(page);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _CatalogueAppBar(
        pdfViewerController: pdfViewerController,
        onJumpTo: () => _jumpTo(context),
      ),
      body: _CatalogueBody(pdfViewerController: pdfViewerController),
      floatingActionButton: _CatalogueZoomControls(
        pdfViewerController: pdfViewerController,
        zoom: zoom,
        onZoomChanged: (z) => setState(() => zoom = z),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  static Future<void> _launchUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}

class _CatalogueAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PdfViewerController pdfViewerController;
  final VoidCallback onJumpTo;

  const _CatalogueAppBar({
    required this.pdfViewerController,
    required this.onJumpTo,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Text(
        Strings.catalogue,
        style: getBoldTextStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s28.sp,
        ),
      ),
      actions: [
        InkWell(
          onTap: () => pdfViewerController.previousPage(),
          child: Icon(Icons.arrow_back_ios, color: ColorManager.primaryColor, size: 20),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => pdfViewerController.nextPage(),
          icon: Icon(Icons.arrow_forward_ios, color: ColorManager.primaryColor, size: 20),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: onJumpTo,
          icon: Icon(Icons.search, color: ColorManager.primaryColor, size: 20),
        ),
        _CallButton(),
        Gap(AppSize.s16.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CatalogueBody extends StatelessWidget {
  final PdfViewerController pdfViewerController;

  const _CatalogueBody({required this.pdfViewerController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p16),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s550.h,
              child: SfPdfViewer.asset(
                'assets/pdfs/moamen_cv.pdf',
                controller: pdfViewerController,
                currentSearchTextHighlightColor: Colors.red,
                otherSearchTextHighlightColor: Colors.red,
              ),
            ),
            Gap(AppSize.s22.h),
            ButtonWidget(
              radius: AppSize.s12.r,
              text: Strings.download,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _CatalogueZoomControls extends StatelessWidget {
  final PdfViewerController pdfViewerController;
  final double zoom;
  final ValueChanged<double> onZoomChanged;

  const _CatalogueZoomControls({
    required this.pdfViewerController,
    required this.zoom,
    required this.onZoomChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            pdfViewerController.zoomLevel = zoom + 1;
            onZoomChanged(zoom + 1);
          },
          icon: const Icon(Icons.zoom_in),
        ),
        IconButton(
          onPressed: () {
            pdfViewerController.zoomLevel = 0.0;
            onZoomChanged(0.0);
          },
          icon: const Icon(Icons.zoom_out),
        ),
      ],
    );
  }
}

class _CallButton extends StatelessWidget {
  const _CallButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _CatalogueViewState._launchUrl("tel:01270492019"),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p12.w,
          vertical: AppPadding.p8.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xfff3f4f9),
          borderRadius: BorderRadius.circular(AppSize.s12.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              IconAssets.call,
              colorFilter: ColorFilter.mode(ColorManager.primaryColor, BlendMode.srcIn),
            ),
            Gap(AppSize.s5.w),
            Text(
              Strings.call,
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JumpToPageDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function(int) onConfirm;

  const _JumpToPageDialog({
    required this.controller,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    int pageNo = 0;

    return AlertDialog(
      title: const Text('Enter page No to jump'),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (val) => pageNo = int.parse(val),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm(pageNo);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

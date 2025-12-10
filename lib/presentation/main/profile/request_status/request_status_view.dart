import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/network_aware_widget.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/main/profile/request_status/request_status_viewmodel.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class RequestStatusView extends StatefulWidget {
  static const String routeName = '/request-status';

  const RequestStatusView({super.key});

  @override
  State<RequestStatusView> createState() => _RequestStatusViewState();
}

class _RequestStatusViewState extends State<RequestStatusView> {
  final _viewmodel = instance<RequestStatusViewModel>();

  @override
  void initState() {
    super.initState();
    _viewmodel.start();
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      onlineChild: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: Strings.requestStatus.tr()),
        body: StreamBuilder<FlowState>(
          stream: _viewmodel.outputStateStream,
          initialData: LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState,
          ),
          builder: (context, snapshot) {
            final state = snapshot.data;
            return state?.getStateWidget(
                  context,
                  _buildContent(),
                  () => _viewmodel.start(),
                ) ??
                _buildContent();
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    final requests = _viewmodel.requests;
    if (requests.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.all(AppSize.s16.w),
        child: Column(
          children: List.generate(requests.length, (index) {
            final req = requests[index];
            final formattedDate = (() {
              try {
                return DateFormat('dd/MM/yyyy - hh:mm a').format(req.createdAt);
              } catch (_) {
                return req.createdAt.toIso8601String();
              }
            })();

            final statusLower = req.status.toLowerCase();
            final badgeColor = statusLower == 'approved'
                ? ColorManager.greenColor
                : statusLower == 'pending'
                ? const Color(0xFFFF9408)
                : ColorManager.lightGreyColor;

            return Padding(
              padding: EdgeInsets.only(bottom: AppSize.s14.h),
              child: Container(
                padding: EdgeInsetsDirectional.all(AppSize.s12.w),
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(AppSize.s12.r),
                  border: Border.all(color: ColorManager.buttonsBorderColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconAssets.request,
                          height: 20.h,
                          width: 20.w,
                        ),
                        Gap(AppSize.s8.w),
                        Expanded(
                          child: Text(
                            req.label,
                            style: getMediumTextStyle(
                              color: ColorManager.primaryColor,
                              fontSize: FontSizeManager.s16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Gap(AppSize.s20.h),

                    Row(
                      children: [
                        Text(
                          formattedDate,
                          style: getRegularTextStyle(
                            color: ColorManager.greyColor,
                            fontSize: FontSizeManager.s14.sp,
                          ),
                        ),
                        const Spacer(),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: AppSize.s5.h,
                        //     horizontal: AppSize.s12.w,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xffC8C8C8),
                        //     borderRadius: BorderRadius.circular(AppSize.s99),
                        //   ),
                        //   child: Text(
                        //     'Edit',
                        //     style: getMediumTextStyle(
                        //       color: Colors.white,
                        //       fontSize: FontSizeManager.s14,
                        //     ),
                        //   ),
                        // ),
                        // Gap(AppSize.s8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSize.s5.h,
                            horizontal: AppSize.s12.w,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(AppSize.s99),
                          ),
                          child: Text(
                            req.status,
                            style: getMediumTextStyle(
                              color: Colors.white,
                              fontSize: FontSizeManager.s14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

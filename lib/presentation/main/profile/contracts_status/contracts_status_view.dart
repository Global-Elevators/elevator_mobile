import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/network_aware_widget.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/main/profile/contracts_status/contracts_status_viewmodel.dart';
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
import 'package:timeline_tile/timeline_tile.dart';

class ContractsStatusView extends StatefulWidget {
  static const String routeName = '/contracts-status';

  const ContractsStatusView({super.key});

  @override
  State<ContractsStatusView> createState() => _ContractsStatusViewState();
}

class _ContractsStatusViewState extends State<ContractsStatusView> {
  final _viewmodel = instance<ContractsStatusViewModel>();

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
        appBar: CustomAppBar(title: Strings.contractsStatus.tr()),
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
    final contracts = _viewmodel.contractsStatusModel?.contracts ?? [];
    if (contracts.isEmpty) {
      return const SizedBox.shrink();
    }

    final firstContract = contracts.first;
    final statusLabel = firstContract.status.label;
    final scopeLabel = firstContract.timeline.scopeLabel;
    final items = firstContract.timeline.items;

    final startDate = DateFormat('yyyy-MM-dd').format(firstContract.startDate);
    final endDate = DateFormat('yyyy-MM-dd').format(firstContract.endDate);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppSize.s16.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: AppSize.s14.h,
                horizontal: AppSize.s16.w,
              ),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(AppSize.s22.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(IconAssets.progressNote),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSize.s8.h,
                          horizontal: AppSize.s12.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff34C759),
                          borderRadius: BorderRadius.circular(AppSize.s99.r),
                        ),
                        child: Text(
                          statusLabel,
                          style: getMediumTextStyle(
                            color: Colors.white,
                            fontSize: FontSizeManager.s16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(AppSize.s12.h),

                  Text(
                    scopeLabel,
                    style: getMediumTextStyle(
                      color: ColorManager.whiteColor,
                      fontSize: FontSizeManager.s22.sp,
                    ),
                  ),

                  Gap(AppSize.s8.h),

                  Row(
                    children: [
                      Text(
                        "Start : $startDate",
                        style: getRegularTextStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSizeManager.s16.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "End : $endDate",
                        style: getRegularTextStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSizeManager.s16.sp,
                        ),
                      ),
                    ],
                  ), // ✔ FIXED MISSING BRACKET
                ],
              ),
            ),

            // ------------------- Timeline -------------------
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isFirst = index == 0;
                final isLast = index == items.length - 1;

                final isCurrent = item.state.toLowerCase() == 'current';

                final formattedDate = (() {
                  try {
                    return DateFormat('dd MMM yyyy').format(item.deadline);
                  } catch (_) {
                    return item.deadline.toIso8601String();
                  }
                })();

                return TimelineTile(
                  isFirst: isFirst,
                  isLast: isLast,
                  indicatorStyle: IndicatorStyle(
                    width: AppSize.s30.w,
                    height: AppSize.s30.h,
                    indicatorXY: 0.4,
                    indicator: isCurrent
                        ? SvgPicture.asset(IconAssets.progressDone)
                        : SvgPicture.asset(IconAssets.progressNotDone),
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Color(0xFFBFC3CF),
                    thickness: 2,
                  ),
                  afterLineStyle: const LineStyle(
                    color: Color(0xFFBFC3CF),
                    thickness: 2,
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: getMediumTextStyle(
                            color: isCurrent
                                ? const Color(0xFF0C2144)
                                : const Color(0xFF6C6C6C),
                            fontSize: FontSizeManager.s16.sp,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: getMediumTextStyle(
                            color: const Color(0xFF9C9C9C),
                            fontSize: FontSizeManager.s14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

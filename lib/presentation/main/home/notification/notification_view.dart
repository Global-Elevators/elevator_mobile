import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/notification/notification_viewmodel.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NotificationView extends StatefulWidget {
  static const String notificationRoute = '/notification';

  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final _viewmodel = instance<NotificationViewModel>();

  @override
  void initState() {
    super.initState();
    _viewmodel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Strings.notifications.tr(),
        showBackButton: true,
        popOrGo: true,
      ),
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
    );
  }

  Widget _buildContent() {
    final notifications = _viewmodel.notificationsModel?.notifications ?? [];

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: AppSize.s16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _viewmodel.readAllNotifications(),
            child: Text(
              Strings.markAllAsRead.tr(),
              style: getMediumTextStyle(
                color: ColorManager.orangeColor,
                fontSize: FontSizeManager.s20,
              ),
            ),
          ),
          Gap(AppSize.s28.h),
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => Gap(AppSize.s16.h),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _notificationItem(
                  title: notification.title,
                  body: notification.body,
                  id: notification.id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationItem({
    required String title,
    required String body,
    required String id,
  }) {
    return Dismissible (
      key: UniqueKey(),
      onDismissed: (direction) => _viewmodel.deleteNotification(id),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          vertical: AppSize.s12.h,
          horizontal: AppSize.s14.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s22.r),
          color: const Color(0xffF8F8F9),
        ),
        child: Row(
          children: [
            Container(
              height: AppSize.s50.h,
              width: AppSize.s50.w,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(AppSize.s8.r),
              ),
              child: Icon(
                Icons.notifications_active_outlined,
                color: ColorManager.primaryColor,
                size: AppSize.s24.h,
              ),
            ),
            Gap(AppSize.s12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getMediumTextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: FontSizeManager.s18.sp,
                    ),
                  ),
                  Text(
                    body,
                    style: getMediumTextStyle(
                      color: ColorManager.greyColor,
                      fontSize: FontSizeManager.s14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
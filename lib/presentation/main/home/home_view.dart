import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/app/navigation_service.dart';
import 'package:elevator/domain/models/next_appointment_model.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/home_viewmodel.dart';
import 'package:elevator/presentation/main/home/request_for_technical/request_for_technical_view.dart';
import 'package:elevator/presentation/main/home/request_site_survey/request_site_survey_view.dart';
import 'package:elevator/presentation/main/widgets/free_button.dart';
import 'package:elevator/presentation/main/widgets/home_bar.dart';
import 'package:elevator/presentation/main/widgets/premium_container.dart';
import 'package:elevator/presentation/main/widgets/registration_box.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  static const String homeRoute = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeViewModel = instance<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _homeViewModel.outputStateStream,
      builder: (context, snapshot) {
        return snapshot.data?.getStateWidget(context, _buildContent(), () {}) ??
            _buildContent();
      },
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
        child: _HomePageBody(
          onAlertAction: _homeViewModel.sendAlert,
          getNextAppointment: _homeViewModel.getNextAppointment,
          nextAppointmentModel: _homeViewModel.nextAppointmentModel,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _homeViewModel.start();
  }
}

class _HomePageBody extends StatelessWidget {
  final VoidCallback onAlertAction;
  final VoidCallback getNextAppointment;
  final NextAppointmentModel? nextAppointmentModel;

  const _HomePageBody({
    required this.onAlertAction,
    required this.getNextAppointment,
    required this.nextAppointmentModel,
  });

  @override
  Widget build(BuildContext context) {
    final data = nextAppointmentModel?.nextAppointmentDataModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeBar(),
        Gap(AppSize.s24.h),

        if (nextAppointmentModel == null)
          Container(),

        if (FlavorConfig.isAccountPaid && data != null) ...[
          RegistrationBox(data),
          Gap(AppSize.s24.h),
        ],

        PremiumContainer(FlavorConfig.isAccountPaid, onAlertAction),
        Gap(AppSize.s24.h),
        _buildSectionTitle(context),
        Gap(AppSize.s12.h),
        const _ServicesRow(),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Text(
      Strings.servicesTitle.tr(),
      style: getBoldTextStyle(
        fontSize: FontSizeManager.s23.sp,
        color: ColorManager.primaryColor,
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onTap;

  const ServiceButton({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FreeButton(title: title, imageAsset: imageAsset, onTap: onTap);
  }
}

class _ServicesRow extends StatelessWidget {
  const _ServicesRow();

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService(instance<AppPreferences>());
    return SizedBox(
      height: AppSize.s130.h,
      child: Row(
        children: [
          ServiceButton(
            title: Strings.requestSiteSurvey.tr(),
            imageAsset: IconAssets.worker,
            onTap: () => navigationService.navigateWithAuthCheck(
              context: context,
              authenticatedRoute: RequestSiteSurvey.requestSiteSurveyRoute,
            ),
          ),
          Gap(AppSize.s8.w),
          ServiceButton(
            title: Strings.requestTechnicalOffer.tr(),
            imageAsset: ImageAssets.note,
            onTap: () => navigationService.navigateWithAuthCheck(
              context: context,
              authenticatedRoute:
                  RequestForTechnicalView.requestForTechnicalRoute,
            ),
          ),
        ],
      ),
    );
  }
}

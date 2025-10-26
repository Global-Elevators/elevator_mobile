import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/account_verified/account_verified_view.dart';
import 'package:elevator/presentation/forget_password/forget_password_view.dart';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/main/catalogue/catalogue_view.dart';
import 'package:elevator/presentation/main/home/home_view.dart';
import 'package:elevator/presentation/main/home/notification_view.dart';
import 'package:elevator/presentation/main/home/report_break_down/report_break_down_view.dart';
import 'package:elevator/presentation/main/home/request_for_technical/request_for_technical_view.dart';
import 'package:elevator/presentation/main/home/request_site_survey/request_site_survey_view.dart';
import 'package:elevator/presentation/main/library/library_view.dart';
import 'package:elevator/presentation/main/main_view.dart';
import 'package:elevator/presentation/main/profile/change_password/change_password_view.dart';
import 'package:elevator/presentation/main/profile/contracts_status/contracts_status_view.dart';
import 'package:elevator/presentation/main/profile/edit_information/edit_information_view.dart';
import 'package:elevator/presentation/main/profile/help/help_view.dart';
import 'package:elevator/presentation/main/profile/profile_view.dart';
import 'package:elevator/presentation/main/profile/request_status/request_status_view.dart';
import 'package:elevator/presentation/new_password/new_password_view.dart';
import 'package:elevator/presentation/register/register_view.dart';
import 'package:elevator/presentation/splash/splash_view.dart';
import 'package:elevator/presentation/verify/verify_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterConfig {
  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: SplashView.splashRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: SplashView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: LoginView.loginRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initLoginModule();
          return getCustomTransitionPage(state: state, child: LoginView());
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: RegisterView.registerRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initRegisterModule();
          return getCustomTransitionPage(state: state, child: RegisterView());
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: VerifyView.verifyRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initVerifyModule();
          initVerifyForgotPasswordModule();
          initResendOtpModule();
          return getCustomTransitionPage(
            state: state,
            child: VerifyView(codes: state.extra as List<String>),
          );
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: AccountVerifiedView.accountVerifiedRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(
              state: state,
              child: AccountVerifiedView(state.extra as String),
            ),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: MainView.mainRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initMainModule();
          return getCustomTransitionPage(state: state, child: MainView());
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: ForgetPasswordView.forgetPasswordRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initForgotPasswordModule();
          return getCustomTransitionPage(
            state: state,
            child: ForgetPasswordView(),
          );
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: NewPasswordView.newPasswordRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initResetPasswordModule();
          return getCustomTransitionPage(
            state: state,
            child: NewPasswordView(state.extra as String),
          );
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: HomePage.homeRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return getCustomTransitionPage(state: state, child: HomePage());
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: CatalogueView.catalogueRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: CatalogueView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: LibraryView.libraryRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: LibraryView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: ProfileView.profileRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: ProfileView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: NotificationView.notificationRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: NotificationView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: ReportBreakDownView.reportBreakDownRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initReportBreakDownModule();
          return getCustomTransitionPage(
            state: state,
            child: ReportBreakDownView(),
          );
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: RequestSiteSurvey.requestSiteSurveyRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initRequestServiceSurveyModule();
          return getCustomTransitionPage(
            state: state,
            child: RequestSiteSurvey(),
          );
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: RequestForTechnicalView.requestForTechnicalRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initTechnicalCommercialOffersModule();
          return getCustomTransitionPage(
            state: state,
            child: RequestForTechnicalView(),
          );
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: EditInformationView.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) {
          initEditInformationModule();
          return getCustomTransitionPage(
            state: state,
            child: EditInformationView(),
          );
        },
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: ContractsStatusView.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: ContractsStatusView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: RequestStatusView.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: RequestStatusView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: ChangePasswordView.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: ChangePasswordView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: HelpView.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            getCustomTransitionPage(state: state, child: HelpView()),
        routes: <RouteBase>[],
      ),
    ],
  );

  static CustomTransitionPage getCustomTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}

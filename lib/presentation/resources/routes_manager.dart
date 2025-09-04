import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/register/register_view.dart';
import 'package:elevator/presentation/splash/splash_view.dart';
import 'package:elevator/presentation/successfully/successfully_view.dart';
import 'package:elevator/presentation/verification/verification_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterConfig {
  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: SplashView.splashRoute,
        pageBuilder:
            (BuildContext context, GoRouterState state) =>
                getCustomTransitionPage(state: state, child: SplashView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: LoginView.loginRoute,
        pageBuilder:
            (BuildContext context, GoRouterState state) =>
                getCustomTransitionPage(state: state, child: LoginView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: RegisterView.registerRoute,
        pageBuilder:
            (BuildContext context, GoRouterState state) =>
                getCustomTransitionPage(state: state, child: RegisterView()),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: VerificationView.verificationRoute,
        pageBuilder:
            (BuildContext context, GoRouterState state) =>
                getCustomTransitionPage(
                  state: state,
                  child: VerificationView(),
                ),
        routes: <RouteBase>[],
      ),
      GoRoute(
        path: SuccessfullyView.successfullyRoute,
        pageBuilder:
            (BuildContext context, GoRouterState state) =>
                getCustomTransitionPage(
                  state: state,
                  child: SuccessfullyView(),
                ),
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

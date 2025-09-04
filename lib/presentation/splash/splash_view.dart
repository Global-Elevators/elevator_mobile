import 'dart:async';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  static const String splashRoute = '/';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  void _goNext() async => goToLoginScreen(context);

  void goToLoginScreen(BuildContext context) =>
      context.go(LoginView.loginRoute);

  _startDelay() => _timer = Timer(const Duration(seconds: 2), _goNext);

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: splashWidget());

  @override
  // why use dispose method? The dispose method is called when the state object is removed, which is when the widget is removed from the tree. This is the place to clean up resources, unsubscribe from streams, etc.
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget splashWidget() => Center(
    child: Stack(
      children: [
        Center(child: Image.asset(ImageAssets.logo)),
        Image.asset(ImageAssets.background),
      ],
    ),
  );
}

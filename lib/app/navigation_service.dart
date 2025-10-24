import 'package:elevator/app/app_pref.dart';
import 'package:elevator/presentation/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final AppPreferences _appPreferences;

  NavigationService(this._appPreferences);

  Future<void> navigateWithAuthCheck({
    required BuildContext context,
    required String authenticatedRoute,
    String unauthenticatedRoute = LoginView.loginRoute,
  }) async {
    final isLoggedIn = await _appPreferences.isUserLoggedIn("login");
    final route = isLoggedIn ? authenticatedRoute : unauthenticatedRoute;
    if (context.mounted) {
      context.push(route);
    }
  }
}
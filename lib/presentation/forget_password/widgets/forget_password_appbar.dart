import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/widgets/back_to_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ForgetPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: BackToSignInButton(
        text: Strings.signInButton,
        route: LoginView.loginRoute,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

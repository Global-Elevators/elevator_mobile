import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  static const String profileRoute = '/profile';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Strings.profile, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

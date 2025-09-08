import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class LibraryView extends StatefulWidget {
  static const String libraryRoute = '/library';

  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Strings.library, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class CatalogueView extends StatefulWidget {
  static const String catalogueRoute = '/catalogue';

  const CatalogueView({super.key});

  @override
  State<CatalogueView> createState() => _CatalogueViewState();
}

class _CatalogueViewState extends State<CatalogueView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Strings.catalogue, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

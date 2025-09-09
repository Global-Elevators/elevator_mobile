import 'package:elevator/presentation/main/catalogue/catalogue_view.dart';
import 'package:elevator/presentation/main/home/view/home_view.dart';
import 'package:elevator/presentation/main/library/library_view.dart';
import 'package:elevator/presentation/main/profile/profile_view.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  static const String mainRoute = '/main';

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _pages = [
    const HomePage(),
    const CatalogueView(),
    const LibraryView(),
    const ProfileView(),
  ];

  int _currentIndex = 0;

  void onItemTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: .20,
        selectedItemColor: ColorManager.primaryColor,
        unselectedItemColor: ColorManager.greyColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: Strings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: Strings.catalogue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_copy_outlined),
            label: Strings.library,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: Strings.profile,
          ),
        ],
        onTap: onItemTapped,
      ),
    );
  }
}
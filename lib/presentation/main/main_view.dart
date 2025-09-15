import 'package:elevator/presentation/main/catalogue/catalogue_view.dart';
import 'package:elevator/presentation/main/home/home_view.dart';
import 'package:elevator/presentation/main/library/library_view.dart';
import 'package:elevator/presentation/main/profile/profile_view.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainView extends StatefulWidget {
  static const String mainRoute = '/main';

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> _pages = [
    const HomePage(),
    const CatalogueView(),
    const LibraryView(),
    const ProfileView(),
  ];

  int _currentIndex = 0;

  void _onItemTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s95.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s50.r),
          topRight: Radius.circular(AppSize.s50.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.15,
            ),
            spreadRadius: 0,
            blurRadius: 45,
            offset: const Offset(0, -3), // shadow ABOVE the nav bar
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s50.r),
          topRight: Radius.circular(AppSize.s50.r),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: ColorManager.primaryColor,
          unselectedItemColor: ColorManager.greyColor,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: currentIndex == 0
                  ? SvgPicture.asset(ImageAssets.homeFill)
                  : SvgPicture.asset(
                      ImageAssets.homeStroke,
                      colorFilter: ColorFilter.mode(
                        ColorManager.notSelectedIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
              label: Strings.home,
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? SvgPicture.asset(ImageAssets.catalogueFill)
                  : SvgPicture.asset(
                      ImageAssets.catalogueStroke,
                      colorFilter: ColorFilter.mode(
                        ColorManager.notSelectedIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
              label: Strings.catalogue,
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 2
                  ? SvgPicture.asset(ImageAssets.libraryFill)
                  : SvgPicture.asset(
                      ImageAssets.libraryStroke,
                      colorFilter: ColorFilter.mode(
                        ColorManager.notSelectedIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
              label: Strings.library,
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 3
                  ? const Icon(Icons.account_circle)
                  : Icon(
                      Icons.account_circle_outlined,
                      color: ColorManager.notSelectedIconColor,
                    ),
              label: Strings.profile,
            ),
          ],
        ),
      ),
    );
  }
}
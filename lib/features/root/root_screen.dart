import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/svg_icon.dart';
import '../home/ui/screens/home_screen.dart';
import '../profile/ui/screens/profile_screen.dart';
import '../saved/Data/Data Sources/saved_local_data_source.dart';
import '../saved/ui/screens/saved_screen.dart';
import '../search/ui/screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    SearchScreen(),
    const SavedScreen(),  
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeSavedBox();
  }

  Future<void> _initializeSavedBox() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    await SavedLocalDataSourceImpl.openBoxForUser(userId);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(icon: AppAssets.homeIcon,    label: 'Home',    index: 0),
                _buildNavItem(icon: AppAssets.searchIcon,  label: 'Search',  index: 1),
                _buildNavItem(icon: AppAssets.bookmarkIcon,   label: 'Saved',   index: 2),
                _buildNavItem(icon: AppAssets.profileIcon, label: 'Profile', index: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              assetPath: icon,
              width: 24.w,
              height: 24.h,
              color: isSelected ? AppColors.primaryColor : AppColors.gray500,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primaryColor : AppColors.gray500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

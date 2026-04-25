import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../placeholder_screens.dart';
import './home_screen.dart';

/// Main app shell with BottomNavigationBar for navigation between screens.
/// 
/// Manages the navigation state and displays the appropriate screen based on
/// the selected navigation item. Implements null-safe code with proper state management.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  /// Currently selected navigation index
  int _selectedIndex = 0;

  /// List of screens for each navigation item
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      // Home screen
      HomeDashboardScreen(
        userName: 'Julian',
        onResumePressed: () {
          // Handle resume study action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Resume Study tapped')),
          );
        },
        onViewMapPressed: () {
          // Handle view map action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('View Map tapped')),
          );
        },
      ),
      // Explore screen
      const ExploreScreen(),
      // Constellation screen
      const ConstellationScreen(),
      // Profile screen
      const ProfileScreen(),
    ];
  }

  /// Handle navigation item tap
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold for basic Material app structure
      backgroundColor: AppColors.background,
      body: IndexedStack(
        // IndexedStack to maintain state of all screens
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Build the bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return Container(
      // Container with custom styling for the navigation bar
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.borderMedium,
            width: 1.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        // BottomNavigationBar for navigation between screens
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        elevation: 0,
        selectedLabelStyle: AppTypography.labelSmall.copyWith(
          color: AppColors.primary,
        ),
        unselectedLabelStyle: AppTypography.labelSmall.copyWith(
          color: AppColors.textTertiary,
        ),
        items: [
          // Home navigation item
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: Container(
              // Active state with background
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingLarge,
                vertical: AppSpacing.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
              ),
              child: const Icon(Icons.home),
            ),
            label: 'Home',
          ),

          // Explore navigation item
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            activeIcon: Container(
              // Active state with background
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingLarge,
                vertical: AppSpacing.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
              ),
              child: const Icon(Icons.explore),
            ),
            label: 'Explore',
          ),

          // Constellation navigation item
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_awesome_outlined),
            activeIcon: Container(
              // Active state with background
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingLarge,
                vertical: AppSpacing.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
              ),
              child: const Icon(Icons.auto_awesome),
            ),
            label: 'Constellation',
          ),

          // Profile navigation item
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: Container(
              // Active state with background
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingLarge,
                vertical: AppSpacing.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
              ),
              child: const Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_sizes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSizes.bottomNavHeight,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            route: '/home',
          ),
          _buildNavItem(
            context,
            index: 1,
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: 'Search',
            route: '/search',
          ),
          _buildNavItem(
            context,
            index: 2,
            icon: Icons.shopping_cart_outlined,
            activeIcon: Icons.shopping_cart,
            label: 'Cart',
            route: '/cart',
          ),
          _buildNavItem(
            context,
            index: 3,
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long,
            label: 'Orders',
            route: '/orders',
          ),
          _buildNavItem(
            context,
            index: 4,
            icon: Icons.person_outlined,
            activeIcon: Icons.person,
            label: 'Profile',
            route: '/profile',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required String route,
  }) {
    final theme = Theme.of(context);
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => context.go(route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withOpacity(0.6),
              size: AppSizes.iconMD,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
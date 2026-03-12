import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/widgets/custom_button.dart';
import 'widgets/profile_menu_item.dart';
import '../data/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to settings
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: profileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileState.error != null
              ? Center(
                  child: Text(
                    profileState.error!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: Column(
                    children: [
                      // Profile header
                      _buildProfileHeader(context, profileState),

                      const SizedBox(height: AppSizes.lg),

                      // Menu items
                      _buildMenuSection(context),

                      const SizedBox(height: AppSizes.lg),

                      // Sign out button
                      CustomButton(
                        text: 'Sign Out',
                        onPressed: () {
                          // TODO: Implement sign out
                        },
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),

                      const SizedBox(height: AppSizes.xl),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileState state) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.md),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          // Profile avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Text(
              () {
                final name = state.user?.name;
                if (name != null && name.isNotEmpty) {
                  return name.substring(0, 1).toUpperCase();
                }
                return 'U';
              }(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: AppSizes.md),

          // Profile info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.user?.name ?? 'User',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppSizes.xs),

                Text(
                  state.user?.email ?? 'user@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSizes.xs),

                Text(
                  state.user?.phoneNumber ?? '+94 XX XXX XXXX',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Edit button
          IconButton(
            onPressed: () {
              // TODO: Navigate to edit profile
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          icon: Icons.location_on,
          title: 'Delivery Addresses',
          subtitle: 'Manage your delivery addresses',
          onTap: () {
            // TODO: Navigate to addresses
          },
        ),

        ProfileMenuItem(
          icon: Icons.payment,
          title: 'Payment Methods',
          subtitle: 'Manage your payment options',
          onTap: () {
            // TODO: Navigate to payment methods
          },
        ),

        ProfileMenuItem(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Manage notification preferences',
          onTap: () {
            // TODO: Navigate to notifications
          },
        ),

        ProfileMenuItem(
          icon: Icons.help,
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          onTap: () {
            // TODO: Navigate to help
          },
        ),

        ProfileMenuItem(
          icon: Icons.info,
          title: 'About',
          subtitle: 'App version and information',
          onTap: () {
            // TODO: Navigate to about
          },
        ),
      ],
    );
  }
}
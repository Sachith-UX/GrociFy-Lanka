import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocify/core/constants/app_sizes.dart';
import 'package:grocify/shared/widgets/bottom_nav_bar.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/category_grid.dart';
import 'widgets/deals_section.dart';
import 'widgets/search_bar_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              const Padding(
                padding: EdgeInsets.all(AppSizes.md),
                child: SearchBarWidget(),
              ),

              // Banner carousel
              const BannerCarousel(),

              // Categories
              Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.md),
                    const CategoryGrid(),
                  ],
                ),
              ),

              // Deals section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: DealsSection(),
              ),

              const SizedBox(height: AppSizes.xl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
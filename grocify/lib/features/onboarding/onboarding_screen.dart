import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../shared/widgets/custom_button.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    const OnboardingItem(
      title: 'Fresh Groceries',
      description: 'Get fresh vegetables, fruits, and groceries delivered to your doorstep',
      image: 'assets/images/onboarding_1.png',
      backgroundColor: AppColors.primary,
    ),
    const OnboardingItem(
      title: 'Fast Delivery',
      description: 'Quick and reliable delivery service within 30 minutes',
      image: 'assets/images/onboarding_2.png',
      backgroundColor: AppColors.secondary,
    ),
    const OnboardingItem(
      title: 'Easy Shopping',
      description: 'Browse, order, and pay with just a few taps',
      image: 'assets/images/onboarding_3.png',
      backgroundColor: Color(0xFF4CAF50),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    // TODO: Mark onboarding as completed
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _buildPage(_items[index]);
            },
          ),

          // Skip button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: AppSizes.lg,
            child: TextButton(
              onPressed: _completeOnboarding,
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + AppSizes.lg,
            left: AppSizes.lg,
            right: AppSizes.lg,
            child: Column(
              children: [
                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _items.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.lg),

                // Next/Get Started button
                CustomButton(
                  text: _currentPage == _items.length - 1 ? 'Get Started' : 'Next',
                  onPressed: _nextPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Container(
      color: item.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image placeholder (you can replace with actual image)
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusXL),
                ),
                child: const Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: AppSizes.xxl),

              // Title
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.md),

              // Description
              Text(
                item.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/models/category_model.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual categories from provider
    final categories = _getMockCategories();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppSizes.sm,
        mainAxisSpacing: AppSizes.sm,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(category: category);
      },
    );
  }

  List<Category> _getMockCategories() {
    return [
      Category(
        id: '1',
        name: 'Fruits',
        iconUrl: 'assets/icons/fruits.png',
        color: '#4CAF50',
        productCount: 25,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Category(
        id: '2',
        name: 'Vegetables',
        iconUrl: 'assets/icons/vegetables.png',
        color: '#8BC34A',
        productCount: 40,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Category(
        id: '3',
        name: 'Dairy',
        iconUrl: 'assets/icons/dairy.png',
        color: '#FFC107',
        productCount: 15,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Category(
        id: '4',
        name: 'Beverages',
        iconUrl: 'assets/icons/beverages.png',
        color: '#2196F3',
        productCount: 20,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => context.go('/products?category=${category.id}'),
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: Color(int.parse(category.color.replaceAll('#', '0xFF'))),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon placeholder
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getCategoryIcon(category.name),
                color: Colors.white,
                size: 24,
              ),
            ),

            const SizedBox(height: AppSizes.xs),

            Text(
              category.name,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'fruits':
        return Icons.apple;
      case 'vegetables':
        return Icons.grass;
      case 'dairy':
        return Icons.egg;
      case 'beverages':
        return Icons.local_drink;
      default:
        return Icons.category;
    }
  }
}
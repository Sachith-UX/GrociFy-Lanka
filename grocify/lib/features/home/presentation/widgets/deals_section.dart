import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/models/product_model.dart';
import '../../../../shared/widgets/product_card.dart';

class DealsSection extends StatelessWidget {
  const DealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual deals from provider
    final deals = _getMockDeals();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hot Deals',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to deals page
              },
              child: const Text('View All'),
            ),
          ],
        ),

        const SizedBox(height: AppSizes.md),

        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: deals.length,
            itemBuilder: (context, index) {
              final product = deals[index];
              return Container(
                width: 180,
                margin: EdgeInsets.only(
                  right: index < deals.length - 1 ? AppSizes.md : 0,
                ),
                child: ProductCard(
                  product: product,
                  onAddToCart: () {
                    // TODO: Add to cart
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Product> _getMockDeals() {
    return [
      Product(
        id: '1',
        name: 'Fresh Apples',
        description: 'Red delicious apples',
        price: 250.0,
        imageUrl: 'assets/images/apple.png',
        categoryId: '1',
        stock: 50,
        isAvailable: true,
        rating: 4.5,
        reviewCount: 25,
        tags: ['fresh', 'organic'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Product(
        id: '2',
        name: 'Organic Bananas',
        description: 'Sweet organic bananas',
        price: 180.0,
        imageUrl: 'assets/images/banana.png',
        categoryId: '1',
        stock: 30,
        isAvailable: true,
        rating: 4.2,
        reviewCount: 18,
        tags: ['organic', 'fresh'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Product(
        id: '3',
        name: 'Fresh Milk',
        description: '1L fresh cow milk',
        price: 320.0,
        imageUrl: 'assets/images/milk.png',
        categoryId: '3',
        stock: 20,
        isAvailable: true,
        rating: 4.8,
        reviewCount: 42,
        tags: ['dairy', 'fresh'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }
}
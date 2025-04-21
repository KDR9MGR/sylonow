import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylonow/data/models/service_model.dart';
import 'package:sylonow/features/wishlist/widgets/wishlist_item_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with actual wishlist data from provider
    final List<ServiceModel> wishlistItems = [
      ServiceModel(
        id: '1',
        title: 'Engagement decoration',
        description: 'A floral engagement decoration creates a romantic and elegant ambiance with lush flower arrangements, including garlands, and a beautifully decorated...',
        price: 22000,
        decoratorId: 'dec1',
        images: ['https://takerentpe.com/media/images/products/2024/03/PUNDECEND1584_1.webp'],
        category: 'Wedding',
        rating: 4.9,
        reviewCount: 102,
      ),
      // Add more items as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  return WishlistItemCard(
                    service: wishlistItems[index],
                    onRemove: () {
                      // TODO: Implement remove from wishlist
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
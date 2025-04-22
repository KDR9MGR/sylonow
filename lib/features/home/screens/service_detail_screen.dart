import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sylonow/utils/constants/app_colors.dart';
import 'package:sylonow/utils/constants/size.dart';
import 'package:sylonow/features/home/widgets/t_customization_sheet.dart';
import 'package:sylonow/utils/widgets/service_card.dart';
import 'package:sylonow/data/models/service_model.dart';

class ServiceDetailScreen extends ConsumerStatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  ConsumerState<ServiceDetailScreen> createState() =>
      _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends ConsumerState<ServiceDetailScreen> {
  int _selectedImageIndex = 0;
  bool _isInCart = false;

  final List<String> _images = [
    'assets/images/carousel_1.jpg',
    'assets/images/carousel_2.jpg',
    'assets/images/carousel_3.jpg',
    'assets/images/carousel_4.jpg',
    'assets/images/carousel_5.jpg',
  ];

  void _showCustomizationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const TCustomizationSheet(),
    );
  }

  void _addToCart() {
    context.push('/checkout', extra: {
      'theme': 'Engagement decoration',
      'venue': 'Default Venue',
      'date': DateTime.now(),
      'time': TimeOfDay.now(),
      'comment': '',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image Section
                Stack(
                  children: [
                    // Main Image with Hero animation
                    Hero(
                      tag: 'service-image-${_images[_selectedImageIndex]}',
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.8,
                        width: double.infinity,
                        child: Image.asset(
                          _images[_selectedImageIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Back Button
                    Positioned(
                      top: 40,
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black, Colors.transparent],
                          ),
                        ),
                      ),
                    ),

                    //Image Carousel
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: SizedBox(
                        height: 54,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            final bool isSelected = index == _selectedImageIndex;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedImageIndex = index),
                              child: Container(
                                width: 54,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Engagement decoration',
                            style: TextStyle(
                              fontSize: TSizes.lg,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹',
                                style: TextStyle(
                                  textBaseline: TextBaseline.ideographic,
                                  height: 1.8,
                                  color: TColors.primary,
                                  fontSize: TSizes.fontSizeMd,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '22',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: TColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Rating Row
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          const Text(
                            '4.9',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(102)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'See reviews',
                            style: TextStyle(
                              color: TColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'A floral engagement decoration creates a romantic and elegant ambiance with lush flower arrangements, cascading garlands, and a beautifully adorned stage. Soft lighting, floral arches, and petal-strewn pathways enhance the charm, making the celebration visually stunning.',
                        style: TextStyle(
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      //Add to cart button 
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: _addToCart,
                              child: const Text('Add to Cart'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            padding: EdgeInsets.all(12),
                            style: IconButton.styleFrom(
                              backgroundColor: TColors.primary.withValues(
                                alpha: 0.1,
                              )
                            ),
                            onPressed: () {},
                            icon: const Icon(Iconsax.heart),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Related Services Section
                      Text(
                        'Related Services',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF222222),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 280.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 220.w,
                              margin: EdgeInsets.only(right: 16.w),
                              child: ServiceCard(
                                service: ServiceModel(
                                  id: 'related-$index',
                                  title: 'Related Service ${index + 1}',
                                  description: 'Similar services you might like',
                                  price: 1999.0,
                                  rating: 4.5,
                                  reviewCount: 45,
                                  images: [_images[index % _images.length]],
                                  decoratorId: 'decorator-1',
                                  category: 'Decoration',
                                ),
                                isGridView: true,
                              ),
                            );
                          },
                        ),
                      ),

                      // Add extra padding at bottom for the floating CTA
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

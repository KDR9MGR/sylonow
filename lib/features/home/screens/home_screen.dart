import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sylonow/utils/constants/image_string.dart';
import 'package:sylonow/utils/widgets/service_card.dart';
import 'package:sylonow/features/home/widgets/app_bar_clipper.dart';
import 'package:sylonow/features/home/widgets/category_card.dart';
import 'package:sylonow/features/home/widgets/service_carousel.dart';
import 'package:sylonow/features/home/provider/services_provider.dart';
import 'package:sylonow/utils/constants/app_colors.dart';       


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    final popularServices = ref.watch(popularServicesProvider);
    final appBarHeight = 0.14.sh; // Screen height based calculation

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: appBarHeight,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: ClipPath(
                clipper: TAppBarClipper(),
                child: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        TImageString.background,
                        fit: BoxFit.cover,
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'bhakti gharat',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Iconsax.location5,
                                          size: 16.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          'Mumbai, India',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Badge(
                                label: Text('4', style: TextStyle(fontSize: 10.sp)),
                                child: IconButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.white.withOpacity(0.2)),
                                  ),
                                  icon: Icon(Iconsax.notification, color: Colors.white, size: 28.sp),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    prefixIcon: Icon(Icons.search, size: 24.sp),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ),

            // Service Carousel
            SliverToBoxAdapter(
              child: SizedBox(
                height: 400.h,
                child: const ServiceCarousel(),
              ),
            ),

            // Categories Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Categories',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 130.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          CategoryCard(
                            title: 'Birthday\n Decoration',
                            imageUrl: 'assets/images/category1.jpg',
                          ),
                          CategoryCard(
                            title: 'Our\n Backer\'s',
                            imageUrl: 'assets/images/category5.jpg',
                          ),
                          CategoryCard(
                            title: 'Wedding &\nEngagement',
                            imageUrl: 'assets/images/category2.jpg',
                          ),
                          CategoryCard(
                            title: 'Corporate\nEvents',
                            imageUrl: 'assets/images/category3.jpg',
                          ),
                          CategoryCard(
                            title: 'Festival\nDecoration',
                            imageUrl: 'assets/images/category4.jpg',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Most Popular Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  'Most Popular',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Popular Services Grid
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.65,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ServiceCard(
                    service: popularServices[index],
                    isGridView: true,
                  ),
                  childCount: popularServices.length,
                ),
              ),
            ),

            // Bottom padding
            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.h),
            ),
          ],
        ),
      ),
    );
  }


}

class _ServiceCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.image,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'service-image-$image',
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹',
                        style: TextStyle(
                          color: TColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 18,
                          color: TColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

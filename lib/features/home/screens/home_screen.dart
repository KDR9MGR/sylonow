import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sylonow/utils/constants/app_colors.dart';
import 'package:sylonow/utils/constants/image_string.dart';
import 'package:sylonow/utils/widgets/service_card.dart';
import 'package:sylonow/features/home/widgets/app_bar_clipper.dart';
import 'package:sylonow/features/home/widgets/category_card.dart';
import 'package:sylonow/features/home/widgets/service_carousel.dart';
import 'package:sylonow/features/home/provider/services_provider.dart';

// Custom Clipper for Bottom Navigation Bar

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0; // Track selected tab

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  // Helper method to build navigation items
  Widget _buildNavItem(int index, String svgPath, String label) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 24,
            width: 24,
            color: isSelected ? TColors.primary : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? TColors.primary : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

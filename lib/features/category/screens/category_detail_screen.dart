import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sylonow/utils/constants/app_colors.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../widgets/service_card.dart';
import '../provider/category_detail_provider.dart';

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverHeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class CategoryDetailScreen extends ConsumerStatefulWidget {
  final String title;
  final String imageUrl;
  final String heroTag;

  const CategoryDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  ConsumerState<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends ConsumerState<CategoryDetailScreen> {
  bool isListView = true;
  String selectedSort = 'Popular';
  String selectedFilter = 'New';
  final searchController = TextEditingController();
  
  final List<String> sortOptions = ['Popular', 'Rating', 'Price: Low to High', 'Price: High to Low'];
  final List<String> filterChips = ['All', 'Top Rated', 'Offers', 'New', 'Premium'];

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search services...',
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[600],
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: filterChips.map((filter) {
          final isSelected = filter == selectedFilter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              
              label: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
              onSelected: (_) => setState(() => selectedFilter = filter),
              backgroundColor: isSelected ? TColors.primary : Colors.white,
              selectedColor: Colors.pink,
              checkmarkColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? Colors.pink[100]! : Colors.grey[300]!,
                ),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSortAndView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedSort,
              icon: const Icon(Icons.keyboard_arrow_down),
              isDense: true,
              items: sortOptions.map((sort) {
                return DropdownMenuItem(
                  value: sort,
                  child: Text(
                    sort,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) setState(() => selectedSort = value);
              },
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(
                isListView ? Icons.grid_view : Icons.view_list,
                color: Colors.grey[700],
                size: 20,
              ),
              onPressed: () => setState(() => isListView = !isListView),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryDetailProvider(widget.heroTag));
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: categoryState.when(
          data: (services) => CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                floating: true,
                snap: true,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                ),
                title: const Text(
                  'Our Services',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: _buildSearchBar(),
                  height: 80,
                ),
                floating: true,
              ),
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: _buildFilterChips(),
                  height: 64,
                ),
                pinned: true,
              ),
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: _buildSortAndView(),
                  height: 56,
                ),
                pinned: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: isListView
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final service = services[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: ServiceCard(
                                title: service.title,
                                description: service.description,
                                price: service.price,
                                rating: service.rating,
                                reviewCount: service.reviewCount,
                                images: service.images,
                                onTap: () {
                                  // Navigate to service detail
                                },
                              ),
                            );
                          },
                          childCount: services.length,
                        ),
                      )
                    : SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final service = services[index];
                            return ServiceCard(
                              title: service.title,
                              description: service.description,
                              price: service.price,
                              rating: service.rating,
                              reviewCount: service.reviewCount,
                              images: service.images,
                              isGridView: true,
                              onTap: () {
                                // Navigate to service detail
                              },
                            );
                          },
                          childCount: services.length,
                        ),
                      ),
              ),
            ],
          ),
          loading: () => const Center(child: LoadingWidget()),
          error: (error, stack) => CustomErrorWidget(
            message: error.toString(),
            onRetry: () => ref.refresh(categoryDetailProvider(widget.heroTag)),
          ),
        ),
      ),
    );
  }
} 
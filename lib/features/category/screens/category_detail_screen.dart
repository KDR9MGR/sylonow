import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../widgets/service_card.dart';
import '../provider/category_detail_provider.dart';

class CategoryDetailScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryDetailProvider(heroTag));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Hero(
                tag: '${heroTag}_title',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              background: Hero(
                tag: heroTag,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (categoryState.isLoading)
            const SliverFillRemaining(
              child: LoadingWidget(),
            )
          else if (categoryState.error != null)
            SliverFillRemaining(
              child: CustomErrorWidget(
                message: categoryState.error!,
                onRetry: () => ref.refresh(categoryDetailProvider(heroTag)),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final service = categoryState.services[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ServiceCard(
                        title: service.name,
                        description: service.description,
                        icon: Icons.spa,
                      ),
                    );
                  },
                  childCount: categoryState.services.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
} 
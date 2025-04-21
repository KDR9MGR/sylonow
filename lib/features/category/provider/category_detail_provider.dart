import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryService {
  final String id;
  final String name;
  final String description;
  final String icon;

  CategoryService({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

class CategoryDetailState {
  final String description;
  final List<CategoryService> services;
  final bool isLoading;
  final String? error;

  CategoryDetailState({
    required this.description,
    required this.services,
    this.isLoading = false,
    this.error,
  });

  CategoryDetailState copyWith({
    String? description,
    List<CategoryService>? services,
    bool? isLoading,
    String? error,
  }) {
    return CategoryDetailState(
      description: description ?? this.description,
      services: services ?? this.services,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CategoryDetailNotifier extends StateNotifier<CategoryDetailState> {
  CategoryDetailNotifier()
      : super(CategoryDetailState(
          description: '',
          services: [],
          isLoading: true,
        ));

  Future<void> loadCategoryDetails(String categoryId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      state = CategoryDetailState(
        description: 'This category offers a wide range of professional services tailored to meet your needs. Our experienced team ensures high-quality results and customer satisfaction.',
        services: [
          CategoryService(
            id: '1',
            name: 'Professional Consultation',
            description: 'One-on-one consultation with industry experts',
            icon: 'consultation',
          ),
          CategoryService(
            id: '2',
            name: 'Custom Solutions',
            description: 'Tailored solutions for your specific requirements',
            icon: 'custom',
          ),
          CategoryService(
            id: '3',
            name: 'Implementation Support',
            description: 'Full support during implementation phase',
            icon: 'support',
          ),
        ],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load category details: ${e.toString()}',
      );
    }
  }
}

final categoryDetailProvider = StateNotifierProvider.family<CategoryDetailNotifier,
    CategoryDetailState, String>((ref, categoryId) {
  return CategoryDetailNotifier()..loadCategoryDetails(categoryId);
}); 
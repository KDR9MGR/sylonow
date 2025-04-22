import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylonow/core/constants/app_assets.dart';
import '../../../data/models/service_model.dart';

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

final categoryDetailProvider = FutureProvider.family<List<ServiceModel>, String>((ref, category) async {
  // TODO: Implement actual service fetching logic
  // This is just mock data for now
  await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
  
  return [
      ServiceModel(
      id: '1',
      title: 'Premium Service 1',
      description: 'This is a premium service with excellent quality.',
      price: 99.99,
      decoratorId: 'dec1',
      images: [AppAssets.cakeImages[0],AppAssets.cakeImages[1]],
      category: 'premium',
      rating: 4.5,
      reviewCount: 128,
    ),
    const ServiceModel(
      id: '2',
      title: 'Standard Service 2',
      description: 'A great service at a reasonable price.',
      price: 59.99,
      decoratorId: 'dec2',
      images: ['https://merakcakes.com/cdn/shop/files/VanillaChocoChipsCake.jpg?v=1713853502','https://merakcakes.com/cdn/shop/files/VanillaChocoChipsCake.jpg?v=1713853502'],
      category: 'standard',
      rating: 4.2,
      reviewCount: 85,
    ),
      ServiceModel(
      id: '3',
      title: 'Standard Service 3',
      description: 'A great service at a reasonable price.',
      price: 59.99,
      decoratorId: 'dec2',
      images: [AppAssets.cakeImages[1],AppAssets.cakeImages[3]],
      category: 'standard',
      rating: 4.2,
      reviewCount: 85,
    ),
    ServiceModel(
      id: '4',
      title: 'Standard Service 4',
      description: 'A great service at a reasonable price.',
      price: 59.99,
      decoratorId: 'dec2',
      images: [AppAssets.cakeImages[2],AppAssets.cakeImages[5]],
      category: 'standard',
      rating: 4.2,
      reviewCount: 85,
    ),
    ServiceModel(
      id: '5',
      title: 'Standard Service 5',
      description: 'Choco Nilla Cake',
      price: 800,
      decoratorId: 'dec2',
      images: [AppAssets.cakeImages[3],AppAssets.cakeImages[5]],
      category: 'standard',
      rating: 4.2,
      reviewCount: 85,
    ),
    ServiceModel(
      id: '6',
      title: 'Standard Service 6',
      description: 'A great service at a reasonable price.',
      price: 59.99,
      decoratorId: 'dec2',
      images: [AppAssets.cakeImages[4],AppAssets.cakeImages[5]],
      category: 'standard',
      rating: 4.2,
      reviewCount: 85,
    ),
    ServiceModel(
      id: '7',
      title: 'Standard Service 7',
      description: 'A great service at a reasonable price.',
      price: 59.99,
      decoratorId: 'dec2',
      images: [AppAssets.cakeImages[3],AppAssets.cakeImages[2]],
      category: 'standard',
      rating: 4.2,
      reviewCount: 85,
    ),
    ServiceModel(
      id: '8',
      title: 'Standard Service 1',
      description: 'A great service at a reasonable price.',
      price: 59.99,
      decoratorId: 'dec2',
      images: [AppAssets.cakeImages[6],AppAssets.cakeImages[5]],
      category: 'standard',
      rating: 4.2,
      reviewCount: 85,
    ),
  
    // Add more mock services as needed
  ];
}); 
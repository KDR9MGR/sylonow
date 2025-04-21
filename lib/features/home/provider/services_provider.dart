import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylonow/data/models/service_model.dart';
import 'package:sylonow/data/services/decoration_services.dart';

final popularServicesProvider = Provider<List<ServiceModel>>((ref) {
  // Sort services by rating and return top rated ones
  final sortedServices = List<ServiceModel>.from(decorationServices)
    ..sort((a, b) => b.rating.compareTo(a.rating));
  return sortedServices.take(6).toList();
});

final servicesByCategoryProvider = Provider.family<List<ServiceModel>, String>((ref, category) {
  return decorationServices
      .where((service) => service.category.toLowerCase() == category.toLowerCase())
      .toList();
}); 
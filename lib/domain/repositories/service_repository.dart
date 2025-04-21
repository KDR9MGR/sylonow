import 'package:sylonow/data/models/service_model.dart';

abstract class ServiceRepository {
  Future<List<ServiceModel>> getServices();
  Future<ServiceModel> getServiceById(String id);
  Future<List<ServiceModel>> getServicesByCategory(String category);
  Future<List<ServiceModel>> getServicesByDecorator(String decoratorId);
  Future<void> createService(ServiceModel service);
  Future<void> updateService(ServiceModel service);
  Future<void> deleteService(String id);
} 
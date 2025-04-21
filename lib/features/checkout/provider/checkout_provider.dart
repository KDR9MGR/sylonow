import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutState {
  final bool isLoading;
  final String? error;
  final double itemTotal;
  final double deliveryFee;
  final double discount;
  final double totalPayable;

  CheckoutState({
    this.isLoading = false,
    this.error,
    this.itemTotal = 32,
    this.deliveryFee = 2,
    this.discount = 35,
    this.totalPayable = 22,
  });

  CheckoutState copyWith({
    bool? isLoading,
    String? error,
    double? itemTotal,
    double? deliveryFee,
    double? discount,
    double? totalPayable,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      itemTotal: itemTotal ?? this.itemTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      totalPayable: totalPayable ?? this.totalPayable,
    );
  }
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier() : super(CheckoutState());

  Future<void> processCheckout() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      // Add your checkout logic here
      // For example, call an API to process the payment
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to process checkout: ${e.toString()}',
      );
    }
  }

  void updateDeliveryFee(double fee) {
    state = state.copyWith(
      deliveryFee: fee,
      totalPayable: state.itemTotal + fee - state.discount,
    );
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier();
}); 
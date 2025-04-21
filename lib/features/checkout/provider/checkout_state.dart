import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylonow/features/checkout/models/payment_method.dart';

enum CheckoutStep {
  details,
  paymentMethod,
  processing,
  success,
}

class CheckoutState {
  final bool isLoading;
  final String? error;
  final CheckoutStep currentStep;
  final bool isOrderPlaced;
  final PaymentMethod? selectedPaymentMethod;

  CheckoutState({
    this.isLoading = false,
    this.error,
    this.currentStep = CheckoutStep.details,
    this.isOrderPlaced = false,
    this.selectedPaymentMethod,
  });

  CheckoutState copyWith({
    bool? isLoading,
    String? error,
    CheckoutStep? currentStep,
    bool? isOrderPlaced,
    PaymentMethod? selectedPaymentMethod,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentStep: currentStep ?? this.currentStep,
      isOrderPlaced: isOrderPlaced ?? this.isOrderPlaced,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier() : super(CheckoutState());

  void selectPaymentMethod(PaymentMethod method) {
    state = state.copyWith(
      selectedPaymentMethod: method,
      currentStep: CheckoutStep.processing,
    );
  }

  Future<void> processCheckout() async {
    try {
      state = state.copyWith(
        currentStep: CheckoutStep.paymentMethod,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to process checkout: ${e.toString()}',
        currentStep: CheckoutStep.details,
      );
    }
  }

  Future<void> processPayment() async {
    if (state.selectedPaymentMethod == null) {
      state = state.copyWith(
        error: 'Please select a payment method',
        currentStep: CheckoutStep.paymentMethod,
      );
      return;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        currentStep: CheckoutStep.processing,
        error: null,
      );

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Simulate order placement
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        isLoading: false,
        currentStep: CheckoutStep.success,
        isOrderPlaced: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to process payment: ${e.toString()}',
        currentStep: CheckoutStep.paymentMethod,
      );
    }
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier();
}); 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sylonow/features/checkout/models/payment_method.dart';
import 'package:sylonow/features/checkout/provider/checkout_state.dart';
import 'package:sylonow/features/checkout/screens/payment_method_screen.dart';
import 'package:sylonow/features/checkout/widgets/address_section.dart';
import 'package:sylonow/features/checkout/widgets/order_summary_section.dart';
import 'package:sylonow/features/checkout/widgets/setup_time_section.dart';
import 'package:sylonow/features/checkout/widgets/total_section.dart';
import 'package:sylonow/features/checkout/widgets/processing_overlay.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({
    super.key,
    required this.theme,
    required this.venue,
    required this.date,
    required this.time,
    required this.comment,
  });

  final String theme;
  final String venue;
  final DateTime date;
  final TimeOfDay time;
  final String comment;

  Future<void> _handleCheckout(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(checkoutProvider.notifier);
    await notifier.processCheckout();

    // Show payment method selection
    if (!context.mounted) return;
    final result = await Navigator.push<PaymentMethod>(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentMethodScreen(),
      ),
    );

    if (result != null) {
      notifier.selectPaymentMethod(result);
      await notifier.processPayment();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutState = ref.watch(checkoutProvider);

    // If order is successful, navigate to success screen
    ref.listen<CheckoutState>(
      checkoutProvider,
      (previous, next) {
        if (next.currentStep == CheckoutStep.success) {
          context.go('/order-success');
        } else if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressSection(
                    address: '$venue, Richardson, California 62639',
                  ),
                  const SizedBox(height: 16),
                  OrderSummarySection(
                    theme: theme,
                    date: date,
                    time: time,
                    comment: comment,
                  ),
                  const SizedBox(height: 16),
                  const SetupTimeSection(),
                  const SizedBox(height: 16),
                  const TotalSection(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: checkoutState.isLoading
                    ? null
                    : () => _handleCheckout(context, ref),
                child: checkoutState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Proceed to Pay'),
              ),
            ),
          ),
        ),
        if (checkoutState.currentStep == CheckoutStep.processing)
          const ProcessingOverlay(),
      ],
    );
  }
} 
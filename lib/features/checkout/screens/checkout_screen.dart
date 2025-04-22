import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sylonow/core/constants/app_assets.dart';
import 'package:sylonow/features/checkout/models/payment_method.dart';
import 'package:sylonow/features/checkout/provider/checkout_state.dart';
import 'package:sylonow/features/checkout/screens/payment_method_screen.dart';
import 'package:sylonow/features/checkout/widgets/address_section.dart';
import 'package:sylonow/features/checkout/widgets/order_summary_section.dart';
import 'package:sylonow/features/checkout/widgets/setup_time_section.dart';
import 'package:sylonow/features/checkout/widgets/total_section.dart';
import 'package:sylonow/features/checkout/widgets/processing_overlay.dart';
import 'package:sylonow/utils/constants/app_colors.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
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

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String? selectedCakeWeight;
  String? selectedCakeImage;
  final double cartValue = 2600.0; // Replace with actual cart value
  final double gstRate = 0.18; // 18% GST

  final List<String> cakeWeights = ['500g', '1kg', '1.5kg', '2kg'];

  Future<void> _handleCheckout(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(checkoutProvider.notifier);
    
    try {
      // Show loading
      await notifier.processCheckout();

      if (!context.mounted) return;

      // Navigate to success screen with replacement to prevent back navigation
      context.goNamed('order-success');
      
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildCakeImage(String imageUrl, bool isSelected) {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSelected ? TColors.primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: Icon(
                  Iconsax.gallery,
                  color: Colors.grey[400],
                  size: 32.sp,
                ),
              ),
            ),
            if (isSelected)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingDetails() {
    final subtotal = cartValue;
    final gstAmount = subtotal * gstRate;
    final deliveryFee = 35.0;
    final discount = cartValue >= 2500 ? 35.0 : 0.0;
    final total = subtotal + gstAmount + deliveryFee - discount;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBillRow('Item Total', '₹${subtotal.toStringAsFixed(2)}'),
          _buildBillRow('GST (18%)', '₹${gstAmount.toStringAsFixed(2)}'),
          _buildBillRow('Delivery Fee', '₹$deliveryFee'),
          if (discount > 0)
            _buildBillRow('Discount', '-₹$discount', isDiscount: true),
          Divider(height: 24.h),
          _buildBillRow(
            'Total Amount',
            '₹${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String amount, {bool isBold = false, bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black87,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalCakeSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(AppAssets.cakeImages[0]),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Iconsax.gallery,
                        color: Colors.grey[400],
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complimentary Cake',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Select your free cake from JustBake',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Select Weight',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children: cakeWeights.map((weight) {
              return FilterChip(
                label: Text(weight),
                selected: selectedCakeWeight == weight,
                onSelected: (selected) {
                  setState(() {
                    selectedCakeWeight = selected ? weight : null;
                  });
                },
                backgroundColor: Colors.grey[100],
                selectedColor: TColors.primary.withOpacity(0.1),
                checkmarkColor: TColors.primary,
                labelStyle: TextStyle(
                  color: selectedCakeWeight == weight 
                      ? TColors.primary
                      : Colors.black87,
                ),
                side: BorderSide(
                  color: selectedCakeWeight == weight 
                      ? TColors.primary
                      : Colors.transparent,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          Text(
            'Select Cake',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppAssets.cakeImages.length,
              itemBuilder: (context, index) {
                final cakeImage = AppAssets.cakeImages[index];
                final isSelected = selectedCakeImage == cakeImage;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCakeImage = isSelected ? null : cakeImage;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: _buildCakeImage(cakeImage, isSelected),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final checkoutState = ref.watch(checkoutProvider);

    // Listen for state changes
    ref.listen<CheckoutState>(
      checkoutProvider,
      (previous, next) {
        if (next.error != null) {
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
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            title: Text(
              'Checkout',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => context.pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            AddressSection(
                              address: '${widget.venue}, Richardson, California 62639',
                            ),
                            Divider(height: 32.h),
                            OrderSummarySection(
                              theme: widget.theme,
                              date: widget.date,
                              time: widget.time,
                              comment: widget.comment,
                            ),
                            Divider(height: 32.h),
                            const SetupTimeSection(),
                            if (cartValue >= 2500) ...[
                              Divider(height: 32.h),
                              _buildPromotionalCakeSection(),
                            ],
                            Divider(height: 32.h),
                            _buildBillingDetails(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: FilledButton(
                onPressed: checkoutState.isLoading
                    ? null
                    : () => _handleCheckout(context, ref),
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: checkoutState.isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Proceed to Pay',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
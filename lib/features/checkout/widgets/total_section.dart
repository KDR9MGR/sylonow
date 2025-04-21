import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalSection extends ConsumerWidget {
  const TotalSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _PriceRow(
          label: 'Item Total',
          value: '\$32',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        _PriceRow(
          label: 'Delivery Fee',
          value: '\$2',
          additionalText: '(\$35 Saved)',
          style: const TextStyle(
            color: Colors.grey,
          ),
          additionalStyle: const TextStyle(
            color: Colors.green,
          ),
        ),
        const Divider(height: 24),
        _PriceRow(
          label: 'Total Payable',
          value: '\$22',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.additionalText,
    this.style,
    this.additionalStyle,
  });

  final String label;
  final String value;
  final String? additionalText;
  final TextStyle? style;
  final TextStyle? additionalStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Row(
          children: [
            Text(value, style: style),
            if (additionalText != null) ...[
              const SizedBox(width: 4),
              Text(additionalText!, style: additionalStyle),
            ],
          ],
        ),
      ],
    );
  }
} 
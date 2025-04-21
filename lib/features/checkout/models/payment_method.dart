import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PaymentType {
  upi,
  card,
  netBanking,
  wallet,
}

class PaymentMethod {
  final String id;
  final String name;
  final IconData icon;
  final PaymentType type;
  final String? subtitle;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    this.subtitle,
  });
}

final List<PaymentMethod> paymentMethods = [
  PaymentMethod(
    id: 'upi',
    name: 'UPI',
    icon: FontAwesomeIcons.qrcode,
    type: PaymentType.upi,
    subtitle: 'Pay using UPI apps',
  ),
  PaymentMethod(
    id: 'card',
    name: 'Credit / Debit Card',
    icon: FontAwesomeIcons.creditCard,
    type: PaymentType.card,
    subtitle: 'Visa, Mastercard, RuPay',
  ),
  PaymentMethod(
    id: 'netbanking',
    name: 'Net Banking',
    icon: FontAwesomeIcons.buildingColumns,
    type: PaymentType.netBanking,
    subtitle: 'All Indian banks',
  ),
  PaymentMethod(
    id: 'wallet',
    name: 'Wallet',
    icon: FontAwesomeIcons.wallet,
    type: PaymentType.wallet,
    subtitle: 'Paytm, PhonePe, Amazon Pay',
  ),
]; 
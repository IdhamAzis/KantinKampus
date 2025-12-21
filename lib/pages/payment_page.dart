import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final int totalPayment;
  final String paymentMethod;

  const PaymentPage({
    super.key,
    required this.totalPayment,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: const Color(0xff188E69),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metode Pembayaran',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(paymentMethod.toUpperCase()),

            const SizedBox(height: 24),

            Text(
              'Total yang Harus Dibayar',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rp $totalPayment',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff188E69),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

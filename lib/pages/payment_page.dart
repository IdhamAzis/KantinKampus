import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final int total;

  const PaymentPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: const Color(0xff188E69),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Total Pembayaran'),
            const SizedBox(height: 10),
            Text(
              'Rp $total',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pembayaran berhasil')),
                );
              },
              child: const Text('Bayar'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/cart_data.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  int get subtotal => cart.fold<int>(
        0,
        (sum, item) =>
            sum + (item['price'] as int) * (item['qty'] as int),
      );

  @override
  Widget build(BuildContext context) {
    const int appFee = 3000;
    const int serviceFee = 2000;

    final int totalPayment = subtotal + appFee + serviceFee;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xff188E69),
        title: const Text('Payment Summary'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= PESANAN =================
            _card(
              title: 'Pesanan Anda',
              child: Column(
                children: cart.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${item['name']} x${item['qty']}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          'Rp ${(item['price'] as int) * (item['qty'] as int)}',
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // ================= RINGKASAN PEMBAYARAN =================
            _card(
              title: 'Ringkasan Pembayaran',
              child: Column(
                children: [
                  _row('Subtotal', subtotal),
                  _row('Biaya Layanan', serviceFee),
                  _row('Biaya Aplikasi', appFee),
                  const Divider(),
                  _row(
                    'Total Pembayaran',
                    totalPayment,
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ================= METODE PEMBAYARAN =================
            _card(
              title: 'Metode Pembayaran',
              child: Row(
                children: const [
                  Icon(Icons.qr_code_2, size: 40, color: Color(0xff188E69)),
                  SizedBox(width: 12),
                  Text(
                    'QRIS (Scan QR)',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff188E69),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  cart.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pembayaran berhasil 🎉'),
                    ),
                  );

                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  'Bayar • Rp $totalPayment',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= WIDGET BANTU =================
  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _row(String label, int value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            'Rp $value',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

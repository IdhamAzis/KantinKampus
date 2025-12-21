import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import 'payment_page.dart';

class OrderReviewPage extends ConsumerStatefulWidget {
  const OrderReviewPage({super.key});

  @override
  ConsumerState<OrderReviewPage> createState() =>
      _OrderReviewPageState();
}

class _OrderReviewPageState
    extends ConsumerState<OrderReviewPage> {

  String selectedPayment = 'qris';

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    final int subtotal = cart.fold<int>(
      0,
      (sum, item) =>
          sum + (item['price'] as int) * (item['qty'] as int),
    );

    final int totalPayment = subtotal + 5000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Pesanan'),
        backgroundColor: const Color(0xff188E69),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              'Rp ${(item['price'] as int) * (item['qty'] as int)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 12),

                _card(
                  title: 'Ringkasan Pembayaran',
                  child: Column(
                    children: [
                      _row('Subtotal', subtotal),
                      _row('Biaya Layanan', 2000),
                      _row('Biaya Aplikasi', 3000),
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

                _card(
                  title: 'Metode Pembayaran',
                  child: Column(
                    children: [
                      _paymentTile(
                        value: 'qris',
                        title: 'QRIS (Scan QR)',
                        icon: Icons.qr_code_2,
                      ),
                      _paymentTile(
                        value: 'cash',
                        title: 'Bayar Tunai',
                        icon: Icons.payments_outlined,
                      ),
                      _paymentTile(
                        value: 'ewallet',
                        title: 'E-Wallet',
                        icon: Icons.account_balance_wallet_outlined,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ================= FOOTER =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentPage(
                        totalPayment: totalPayment,
                        paymentMethod: selectedPayment,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Bayar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================

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
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
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
              fontWeight: isBold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentTile({
    required String value,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => selectedPayment = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 36, color: const Color(0xff188E69)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: selectedPayment,
              activeColor: const Color(0xff188E69),
              onChanged: (val) =>
                  setState(() => selectedPayment = val!),
            ),
          ],
        ),
      ),
    );
  }
}

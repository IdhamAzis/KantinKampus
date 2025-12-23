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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: const Color(0xff188E69),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= RINGKASAN PEMBAYARAN =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Pembayaran',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _row('Metode', paymentMethod.toUpperCase()),
                    const SizedBox(height: 8),
                    _row('Total Bayar', 'Rp $totalPayment',
                        isBold: true),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= DETAIL METODE =================
            if (paymentMethod == 'qris') ...[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text(
                        'Scan QR untuk Membayar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      // QR PLACEHOLDER
                      Icon(
                        Icons.qr_code_2,
                        size: 180,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),

                      SizedBox(height: 12),
                      Text(
                        'Gunakan aplikasi e-wallet / m-banking',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (paymentMethod == 'cash') ...[
              _infoCard(
                icon: Icons.payments_outlined,
                text:
                    'Silakan lakukan pembayaran tunai di kasir',
              ),
            ] else ...[
              _infoCard(
                icon: Icons.account_balance_wallet_outlined,
                text:
                    'Pembayaran akan diproses melalui e-wallet',
              ),
            ],

            const Spacer(),

            // ================= BUTTON SELESAI =================
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pembayaran berhasil 🎉'),
                    ),
                  );

                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                },
                child: const Text(
                  'Saya Sudah Bayar',
                  style: TextStyle(
                    color: Colors.white,
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

  // ================= ROW HELPER =================
  Widget _row(String label, String value,
      {bool isBold = false}) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : null,
            color: isBold ? const Color(0xff188E69) : null,
          ),
        ),
      ],
    );
  }

  // ================= INFO CARD =================
  Widget _infoCard({
    required IconData icon,
    required String text,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon,
                size: 36, color: const Color(0xff188E69)),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}

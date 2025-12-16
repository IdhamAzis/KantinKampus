import 'package:flutter/material.dart';
import '../widgets/kantin_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xff188E69),
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Kantin Kampus UNIBI',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      // ================= BODY (FOOTER FIX) =================
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // ===== SELAMAT DATANG CARD =====
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xff22B586),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat Datang 👋',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Kantin Kampus UNIBI menyediakan berbagai pilihan makanan dan minuman favorit mahasiswa dengan harga terjangkau.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ===== PILIH KANTIN CARD =====
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                            decoration: BoxDecoration(
                              color: const Color(0xff22B586),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Pilih Kantin',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Silakan pilih kantin untuk melihat menu',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    KantinCard(
                                      title: 'Kantin Kampus 1',
                                      image: 'assets/image/kantin1.jpg',
                                      address:
                                          'Gedung A – Lantai 1, Kampus UNIBI',
                                    ),
                                    SizedBox(width: 16),
                                    KantinCard(
                                      title: 'Kantin Kampus 2',
                                      image: 'assets/image/kantin1.jpg',
                                      address:
                                          'Gedung B – Area Parkir, Kampus UNIBI',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(), // 🔥 KUNCI FOOTER NEMPEL BAWAH
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // ================= FOOTER =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xff636B76),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Kantin Kampus UNIBI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Mudah • Cepat • Terjangkau',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 6),
            Text(
              '© 2025 UNIBI',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

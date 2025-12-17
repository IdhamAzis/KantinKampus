import 'package:flutter/material.dart';
import '../widgets/kantin_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xff188E69),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Kantin Kampus UNIBI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= HERO CARD =================
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage('assets/image/kantin1.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'BELANJA CEPAT & PRAKTIS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'KANTIN KAMPUS UNIBI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Nikmati kemudahan memesan makanan dan minuman favorit mahasiswa langsung dari aplikasi.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ================= PILIH KANTIN =================
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pilih Kantin',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: const [
                Expanded(
                  child: KantinCard(
                    title: 'Kantin Kampus 1',
                    image: 'assets/image/kantin1.jpg',
                    address: 'Gedung A – Lantai 1',
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: KantinCard(
                    title: 'Kantin Kampus 2',
                    image: 'assets/image/kantin2.jpg',
                    address: 'Gedung B – Area Parkir',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================= MENU ICON WIDGET =================
class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MenuIcon({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffE6F4EF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 26,
                color: const Color(0xff188E69),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

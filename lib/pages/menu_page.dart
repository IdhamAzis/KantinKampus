import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../providers/cart_provider.dart';
import 'order_bottom_sheet.dart';
import '../models/menu_model.dart';
import '../widgets/menu_grid_card.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsync = ref.watch(menuProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kantin Kampus'),
        backgroundColor: const Color(0xff188E69),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            menuAsync.when(
              data: (menus) => SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ================= MENU REKOMENDASI =================
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        'Menu Rekomendasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(
  height: 300,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    itemCount: menus.length,
    itemBuilder: (_, i) => Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 170,
        child: MenuGridCard(
          item: menus[i],
          onAdd: () =>
              ref.read(cartProvider.notifier).add(menus[i]),
        ),
      ),
    ),
  ),
),


                    const SizedBox(height: 24),

                    // ================= MENU LAINNYA =================
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Menu Lainnya',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 1),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.65,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  ),
  itemCount: menus.length,
  itemBuilder: (_, i) => MenuGridCard(
    item: menus[i],
    onAdd: () =>
        ref.read(cartProvider.notifier).add(menus[i]),
  ),
),

                    ),
                  ],
                ),
              ),
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text(e.toString())),
            ),

            const OrderBottomSheet(),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
/// ===================== WIDGET CARD REKOMENDASI ==========================
//////////////////////////////////////////////////////////////////////////////
class _MenuRecommendCard extends StatelessWidget {
  final MenuModel item;
  final VoidCallback onAdd;

  const _MenuRecommendCard({
    required this.item,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                item.image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Rp ${item.price}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: OutlinedButton(
                      onPressed: onAdd,
                      child: const Text('Tambah'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//////////////////////////////////////////////////////////////////////////////
/// ======================= WIDGET CARD GRID ===============================
//////////////////////////////////////////////////////////////////////////////
class _MenuGridCard extends StatelessWidget {
  final MenuModel item;
  final VoidCallback onAdd;

  const _MenuGridCard({
    required this.item,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              item.image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  'Rp ${item.price}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: OutlinedButton(
                    onPressed: onAdd,
                    child: const Text('Tambah'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


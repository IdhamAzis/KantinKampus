import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/menu_grid_card.dart';
import 'order_bottom_sheet.dart';

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

      /// ⬇️ SAFE AREA DI BODY
      body: SafeArea(
        bottom: false, // karena bottom sudah di-handle OrderBottomSheet
        child: Stack(
          children: [
            /// GRID MENU
            menuAsync.when(
  data: (menus) => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Menu Rekomendasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// ===== HORIZONTAL MENU =====
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: menus.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: MenuGridCard(
                item: menus[i],
                onAdd: () => ref
                    .read(cartProvider.notifier)
                    .add(menus[i]),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// ===== MENU LAINNYA (GRID) =====
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Menu Lainnya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: menus.length,
            itemBuilder: (_, i) => MenuGridCard(
              item: menus[i],
              onAdd: () => ref
                  .read(cartProvider.notifier)
                  .add(menus[i]),
            ),
          ),
        ),
      ],
    ),
  ),
  loading: () =>
      const Center(child: CircularProgressIndicator()),
  error: (e, _) => Center(child: Text(e.toString())),
),


            /// ⬇️ BOTTOM ORDER (AMAN DENGAN SAFE AREA)
            const OrderBottomSheet(),
          ],
        ),
      ),
    );
  }
}

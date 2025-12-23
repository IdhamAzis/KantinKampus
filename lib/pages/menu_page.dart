import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/menu_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/menu_grid_card.dart';
import 'order_bottom_sheet.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  final TextEditingController searchController = TextEditingController();
  String keyword = '';

  @override
  Widget build(BuildContext context) {
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
              data: (menus) {
                // ================= FILTER SEARCH =================
                final filteredMenus = menus.where((menu) {
                  return menu.name
                      .toLowerCase()
                      .contains(keyword.toLowerCase());
                }).toList();

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= SEARCH BAR =================
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              keyword = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari menu...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 228, 228, 228),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      // ================= MENU REKOMENDASI =================
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredMenus.length,
                          itemBuilder: (_, i) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 170,
                              child: MenuGridCard(
                                item: filteredMenus[i],
                                onAdd: () => ref
                                    .read(cartProvider.notifier)
                                    .add(filteredMenus[i]),
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

                      const SizedBox(height: 12),

                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: filteredMenus.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (_, i) => MenuGridCard(
                            item: filteredMenus[i],
                            onAdd: () => ref
                                .read(cartProvider.notifier)
                                .add(filteredMenus[i]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text(e.toString())),
            ),

            // ================= BOTTOM SHEET =================
            const OrderBottomSheet(),
          ],
        ),
      ),
    );
  }
}

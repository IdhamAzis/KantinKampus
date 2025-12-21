import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import 'order_review_page.dart';

class OrderBottomSheet extends ConsumerStatefulWidget {
  const OrderBottomSheet({super.key});

  @override
  ConsumerState<OrderBottomSheet> createState() =>
      _OrderBottomSheetState();
}

class _OrderBottomSheetState
    extends ConsumerState<OrderBottomSheet> {
  bool expanded = false;

  // ================= TOTAL =================
  int get total {
    final cart = ref.watch(cartProvider);
    return cart.fold<int>(
      0,
      (sum, item) =>
          sum + (item['price'] as int) * (item['qty'] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    if (cart.isEmpty) return const SizedBox();

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      bottom: 0,
      left: 0,
      right: 0,
      height: expanded ? 320 : 90,
      child: Material(
        elevation: 16,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(22)),
        color: Colors.white,
        child: Column(
          children: [
            /// DRAG HANDLE
            GestureDetector(
              onTap: () => setState(() => expanded = !expanded),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            /// LIST PESANAN
            if (expanded)
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: cart.length,
                  itemBuilder: (_, i) {
                    final item = cart[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Text('Rp ${item['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  cartNotifier.decrease(i),
                            ),
                            Text(
                              item['qty'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  cartNotifier.increase(i),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            /// BUTTON LANJUTKAN
            Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                width: double.infinity,
                height: 35,
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
                builder: (_) => const OrderReviewPage(),
              ),
            );
          },
      child: const Text(
        'Lanjutkan',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/cart_data.dart';
import 'payment_page.dart';

class MenuPage extends StatefulWidget {
  final String kantin;

  const MenuPage({
    super.key,
    required this.kantin,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isExpanded = false;

  final List<Map<String, dynamic>> menuList = [
    {
      'name': 'Nasi Goreng',
      'price': 15000,
      'image': 'assets/image/nasi_goreng.jpg',
    },
    {
      'name': 'Mie Ayam',
      'price': 12000,
      'image': 'assets/image/mie_ayam.jpg',
    },
    {
      'name': 'Es Teh',
      'price': 5000,
      'image': 'assets/image/es_teh.jpg',
    },
    {
      'name': 'Es Jeruk',
      'price': 7000,
      'image': 'assets/image/es_jeruk.jpg',
    },
  ];

  // ================= CART LOGIC =================
  void addToCart(Map<String, dynamic> item) {
    final index = cart.indexWhere((e) => e['name'] == item['name']);

    setState(() {
      if (index >= 0) {
        cart[index]['qty']++;
      } else {
        cart.add({
          'name': item['name'],
          'price': item['price'],
          'qty': 1,
        });
      }
    });
  }

  void increaseQty(int index) {
    setState(() => cart[index]['qty']++);
  }

  void decreaseQty(int index) {
    setState(() {
      if (cart[index]['qty'] > 1) {
        cart[index]['qty']--;
      } else {
        cart.removeAt(index);
      }
    });
  }

  int get total => cart.fold<int>(
        0,
        (sum, item) =>
            sum + (item['price'] as int) * (item['qty'] as int),
      );

  void resetCart() {
    setState(() {
      cart.clear();
      isExpanded = false;
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xff188E69),
        title: Text(widget.kantin),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // ================= MENU GRID =================
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              cart.isEmpty ? 16 : (isExpanded ? 360 : 170),
            ),
            child: GridView.builder(
              itemCount: menuList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = menuList[index];
                return _MenuCard(
                  name: item['name'],
                  price: item['price'],
                  image: item['image'],
                  onAdd: () => addToCart(item),
                );
              },
            ),
          ),

          // ================= BOTTOM CART =================
          if (cart.isNotEmpty)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(22)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          setState(() => isExpanded = !isExpanded),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isExpanded
                                ? 'Sembunyikan Pesanan'
                                : 'Lihat Pesanan',
                            style:
                                const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    if (isExpanded) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 360,
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final item = cart[index];
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => decreaseQty(index),
                                ),
                                Text('${item['qty']}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => increaseQty(index),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 10),

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
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PaymentPage(),
                            ),
                          );
                          resetCart();
                        },
                        child: Text(
                          'Bayar • Rp $total',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ================= MENU CARD =================
class _MenuCard extends StatelessWidget {
  final String name;
  final int price;
  final String image;
  final VoidCallback onAdd;

  const _MenuCard({
    required this.name,
    required this.price,
    required this.image,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // ===== IMAGE =====
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),

            // ===== DARK OVERLAY =====
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.45),
              ),
            ),

            // ===== CONTENT =====
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp $price',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff188E69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Tambah',
                        style: TextStyle(color: Colors.white),
                      ),
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

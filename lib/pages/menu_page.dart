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

  /// WAJIB string default (anti crash Flutter Web)
  String searchQuery = '';

  final List<Map<String, dynamic>> menuList = [
    {
      'name': 'Nasi Goreng Spesial',
      'desc': 'Nasi goreng dengan telur dan ayam',
      'price': 15000,
      'image': 'assets/image/nasi_goreng.jpg',
    },
    {
      'name': 'Mie Ayam Bakso',
      'desc': 'Mie ayam dengan bakso sapi',
      'price': 12000,
      'image': 'assets/image/mie_ayam.jpg',
    },
    {
      'name': 'Ayam Geprek',
      'desc': 'Ayam crispy sambal pedas',
      'price': 18000,
      'image': 'assets/image/nasi_goreng.jpg',
    },
    {
      'name': 'Es Teh Manis',
      'desc': 'Teh segar dingin',
      'price': 5000,
      'image': 'assets/image/es_teh.jpg',
    },
    {
      'name': 'Es Jeruk Peras',
      'desc': 'Jeruk segar asli',
      'price': 7000,
      'image': 'assets/image/es_jeruk.jpg',
    },
    {
      'name': 'Jus Alpukat',
      'desc': 'Alpukat creamy dengan coklat',
      'price': 12000,
      'image': 'assets/image/es_jeruk.jpg',
    },
  ];

  // ================= FILTER MENU (ANTI ERROR) =================
  List<Map<String, dynamic>> get filteredMenu {
    final query = searchQuery.trim().toLowerCase();

    if (query.isEmpty) return menuList;

    return menuList.where((menu) {
      final name = (menu['name'] ?? '').toString().toLowerCase();
      final desc = (menu['desc'] ?? '').toString().toLowerCase();

      return name.contains(query) || desc.contains(query);
    }).toList();
  }

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
          // ================= CONTENT =================
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              cart.isEmpty ? 16 : (isExpanded ? 360 : 170),
            ),
            child: Column(
              children: [
                // ================= SEARCH =================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'Cari menu (mie, ayam, es)',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ================= MENU LIST =================
                Expanded(
                  child: filteredMenu.isEmpty
                      ? const Center(
                          child: Text(
                            'Menu tidak ditemukan',
                            style: TextStyle(color: Colors.black54),
                          ),
                        )
                      : ListView.separated(
                          itemCount: filteredMenu.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = filteredMenu[index];
                            return _MenuCard(
                              name: item['name'],
                              desc: item['desc'],
                              price: item['price'],
                              image: item['image'],
                              onAdd: () => addToCart(item),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),

          // ================= BOTTOM CART =================
          if (cart.isNotEmpty)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
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
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    if (isExpanded)
                      SizedBox(
                        height: 240,
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (_, i) {
                            final item = cart[i];
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      '${item['name']} x${item['qty']}'),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => decreaseQty(i),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => increaseQty(i),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 8),
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
  final String desc;
  final int price;
  final String image;
  final VoidCallback onAdd;

  const _MenuCard({
    required this.name,
    required this.desc,
    required this.price,
    required this.image,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                      color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp $price',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 70,
                height: 28,
                child: OutlinedButton(
                  onPressed: onAdd,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xff188E69),
                    side:
                        const BorderSide(color: Color(0xff188E69)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

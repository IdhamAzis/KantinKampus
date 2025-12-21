import 'package:flutter/material.dart';
import '../models/menu_model.dart';

class MenuGridCard extends StatelessWidget {
  final MenuModel item;
  final VoidCallback onAdd;

  const MenuGridCard({
    super.key,
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
      clipBehavior: Clip.antiAlias, // ⬅️ PENTING
      child: Column(
        children: [
          // ================= IMAGE =================
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              item.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.fastfood,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),

          // ================= CONTENT =================
          Expanded( // ⬅️ INI KUNCI OVERFLOW FIX
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ===== NAMA MENU =====
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),

                  // ===== HARGA =====
                  Text(
                    'Rp ${item.price}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),

                  // ===== BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    height: 32, // ⬅️ JANGAN TERLALU TINGGI
                    child: OutlinedButton(
                      onPressed: onAdd,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Tambah',
                        style: TextStyle(fontSize: 12),
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

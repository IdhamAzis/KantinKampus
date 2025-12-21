import 'package:flutter/material.dart';

class MenuDetailPage extends StatelessWidget {
  final String name;
  final int price;
  final String image;

  const MenuDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff188E69),
        title: Text(name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp $price',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
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


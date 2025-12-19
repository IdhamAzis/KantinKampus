import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/menu_model.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, List<Map<String, dynamic>>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CartNotifier() : super([]);

  void add(MenuModel item) {
    final index = state.indexWhere((e) => e['name'] == item.name);

    if (index >= 0) {
      state[index]['qty']++;
      state = [...state];
    } else {
      state = [
        ...state,
        {
          'name': item.name,
          'price': item.price,
          'qty': 1,
        }
      ];
    }
  }

  void increase(int i) {
    state[i]['qty']++;
    state = [...state];
  }

  void decrease(int i) {
    if (state[i]['qty'] > 1) {
      state[i]['qty']--;
      state = [...state];
    } else {
      state.removeAt(i);
      state = [...state];
    }
  }
}

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';

final menuProvider = FutureProvider<List<MenuModel>>((ref) async {
  final res = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood'),
  );

  final data = jsonDecode(res.body);
  final meals = data['meals'] as List;

  return meals.map((e) => MenuModel.fromJson(e)).toList();
});

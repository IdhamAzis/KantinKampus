class MenuModel {
  final String name;
  final String image;
  final int price;

  MenuModel({
    required this.name,
    required this.image,
    required this.price,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
  final id = json['idMeal'].toString();

  return MenuModel(
    name: json['strMeal'],
    image: json['strMealThumb'],
    price: (id.hashCode % 5 + 1) * 5000, // 5k – 25k
  );
}

}

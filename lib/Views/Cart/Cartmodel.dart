import 'package:meal_app/New/Apimodel.dart';

class CartItem {
  final Recipe recipe;
  int quantity;

  CartItem({required this.recipe, this.quantity = 1});

  double get totalPrice =>
      recipe.caloriesPerServing * 0.1 * quantity; // سعر تقريبي

  Map<String, dynamic> toJson() {
    return {'recipe': recipe.toJson(), 'quantity': quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      recipe: Recipe.fromJson(json['recipe']),
      quantity: json['quantity'] ?? 1,
    );
  }
}

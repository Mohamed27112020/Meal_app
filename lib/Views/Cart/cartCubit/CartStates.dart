import 'package:meal_app/Views/Cart/Cartmodel.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded(this.items);

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.14; // 14% ضريبة
  double get delivery => items.isEmpty ? 0 : 5.0; // رسوم توصيل
  double get total => subtotal + tax + delivery;
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}

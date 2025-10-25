import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Views/Cart/Cartmodel.dart';
import 'package:meal_app/Views/Cart/cartCubit/CartStates.dart';
import 'package:meal_app/New/Apimodel.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    _loadCart();
  }

  final List<CartItem> _cartItems = [];

  void _loadCart() {
    emit(CartLoaded(_cartItems));
  }

  // Add recipe to cart
  void addToCart(Recipe recipe) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.recipe.id == recipe.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(recipe: recipe));
    }

    emit(CartLoaded(List.from(_cartItems)));
  }

  // Remove from cart
  void removeFromCart(int recipeId) {
    _cartItems.removeWhere((item) => item.recipe.id == recipeId);
    emit(CartLoaded(List.from(_cartItems)));
  }

  // Update quantity
  void updateQuantity(int recipeId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(recipeId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.recipe.id == recipeId);
    if (index != -1) {
      _cartItems[index].quantity = quantity;
      emit(CartLoaded(List.from(_cartItems)));
    }
  }

  // Increase quantity
  void increaseQuantity(int recipeId) {
    final index = _cartItems.indexWhere((item) => item.recipe.id == recipeId);
    if (index != -1) {
      _cartItems[index].quantity++;
      emit(CartLoaded(List.from(_cartItems)));
    }
  }

  // Decrease quantity
  void decreaseQuantity(int recipeId) {
    final index = _cartItems.indexWhere((item) => item.recipe.id == recipeId);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        removeFromCart(recipeId);
      }
      emit(CartLoaded(List.from(_cartItems)));
    }
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    emit(CartLoaded([]));
  }

  // Check if recipe is in cart
  bool isInCart(int recipeId) {
    return _cartItems.any((item) => item.recipe.id == recipeId);
  }

  // Get cart item count
  int getItemCount(int recipeId) {
    final item = _cartItems.firstWhere(
      (item) => item.recipe.id == recipeId,
      orElse:
          () => CartItem(
            recipe: Recipe(
              id: 0,
              name: '',
              ingredients: [],
              instructions: [],
              prepTimeMinutes: 0,
              cookTimeMinutes: 0,
              servings: 0,
              difficulty: '',
              cuisine: '',
              caloriesPerServing: 0,
              tags: [],
              userId: 0,
              image: '',
              rating: 0,
              reviewCount: 0,
              mealType: [],
            ),
          ),
    );
    return item.recipe.id != 0 ? item.quantity : 0;
  }
}

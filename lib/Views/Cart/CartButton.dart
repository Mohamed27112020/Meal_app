import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Views/Cart/CartScreen.dart';
import 'package:meal_app/Views/Cart/cartCubit/CartCubit.dart';
import 'package:meal_app/Views/Cart/cartCubit/CartStates.dart';
import 'package:meal_app/New/Apimodel.dart';

class AddToCartButton extends StatelessWidget {
  final Recipe recipe;

  const AddToCartButton({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final isInCart = cubit.isInCart(recipe.id);

        if (isInCart) {
          return ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCartPage()),
              );
            },
            icon: Icon(Icons.shopping_cart),
            label: Text('View Cart'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          );
        }

        return ElevatedButton.icon(
          onPressed: () {
            cubit.addToCart(recipe);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${recipe.name} added to cart'),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ),
            );
          },
          icon: Icon(Icons.add_shopping_cart),
          label: Text('Add to Cart'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        );
      },
    );
  }
}

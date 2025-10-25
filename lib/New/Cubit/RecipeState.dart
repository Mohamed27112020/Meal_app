import 'package:meal_app/New/Apimodel.dart';

abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;
  final int total;
  final bool hasMore;

  RecipeLoaded({
    required this.recipes,
    required this.total,
    required this.hasMore,
  });
}

class RecipeError extends RecipeState {
  final String message;
  RecipeError(this.message);
}

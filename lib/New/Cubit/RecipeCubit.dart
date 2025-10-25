// 5. Recipe Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/New/ApiServices.dart';
import 'package:meal_app/New/Apimodel.dart';
import 'package:meal_app/New/Cubit/RecipeState.dart';


class RecipeCubit extends Cubit<RecipeState> {
  final RecipeApiService _apiService = RecipeApiService();
  List<Recipe> _allRecipes = [];
  int _currentSkip = 0;
  final int _limit = 30;

  RecipeCubit() : super(RecipeInitial());

  // Load initial recipes
  Future<void> loadRecipes() async {
    try {
      emit(RecipeLoading());
      _currentSkip = 0;
      _allRecipes = [];

      final response = await _apiService.getRecipes(
        skip: _currentSkip,
        limit: _limit,
      );
      _allRecipes = response.recipes;
      _currentSkip += _limit;

      emit(
        RecipeLoaded(
          recipes: _allRecipes,
          total: response.total,
          hasMore: response.hasMore,
        ),
      );
    } catch (e) {
      emit(RecipeError('Failed to load recipes: $e'));
    }
  }

  // Load more recipes (pagination)
  Future<void> loadMoreRecipes() async {
    if (state is! RecipeLoaded) return;

    try {
      final currentState = state as RecipeLoaded;
      if (!currentState.hasMore) return;

      final response = await _apiService.getRecipes(
        skip: _currentSkip,
        limit: _limit,
      );
      _allRecipes.addAll(response.recipes);
      _currentSkip += _limit;

      emit(
        RecipeLoaded(
          recipes: _allRecipes,
          total: response.total,
          hasMore: response.hasMore,
        ),
      );
    } catch (e) {
      emit(RecipeError('Failed to load more recipes: $e'));
    }
  }

  // Search recipes
  Future<void> searchRecipes(String query) async {
    try {
      emit(RecipeLoading());
      final response = await _apiService.searchRecipes(query);

      emit(
        RecipeLoaded(
          recipes: response.recipes,
          total: response.total,
          hasMore: false,
        ),
      );
    } catch (e) {
      emit(RecipeError('Failed to search recipes: $e'));
    }
  }

  // Get recipe by ID
  Future<Recipe?> getRecipeById(int id) async {
    try {
      return await _apiService.getRecipeById(id);
    } catch (e) {
      return null;
    }
  }
}

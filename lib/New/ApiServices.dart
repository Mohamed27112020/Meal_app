import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meal_app/New/Apimodel.dart';

class RecipeApiService {
  static const String baseUrl = 'https://dummyjson.com';

  // Fetch all recipes
  Future<RecipeResponse> getRecipes({int skip = 0, int limit = 30}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes?skip=$skip&limit=$limit'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return RecipeResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recipes: $e');
    }
  }

  // Fetch single recipe by ID
  Future<Recipe> getRecipeById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/recipes/$id'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Recipe.fromJson(jsonData);
      } else {
        throw Exception('Failed to load recipe: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recipe: $e');
    }
  }

  // Search recipes by name
  Future<RecipeResponse> searchRecipes(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes/search?q=$query'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return RecipeResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to search recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching recipes: $e');
    }
  }
}

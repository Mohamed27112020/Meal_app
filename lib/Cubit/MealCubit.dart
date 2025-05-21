import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Cubit/MealStates.dart';
import 'package:meal_app/model/Mealmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealCubit extends Cubit<Mealstates> {
  MealCubit() : super(Mealinitstate());
  static const String _prefsKey = 'saved_list';
  List<Meal> loadmeals = [];
  List<Meal> meals = [
    Meal(
      name: "pasta",
      imageUrl:
          "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGFzdGF8ZW58MHx8MHx8fDA%3D",
      description: "pastapastapastapastapastapastapastapastapasta",
      rate: "2.5",
      time: "10 min",
    ),
    Meal(
      name: "Breakfast",
      imageUrl:
          "https://images.unsplash.com/photo-1528699633788-424224dc89b5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8QnJlYWtmYXN0fGVufDB8fDB8fHww",
      description: "BreakfastBreakfastBreakfastBreakfastBreakfast",
      rate: "4.5",
      time: "20 min",
    ),
    Meal(
      name: "Cheese Burger",
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1684349034700-d3abbaa83ee1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2hlZXNlYnVyZ2VyfGVufDB8fDB8fHww",
      description:
          "Cheese BurgerCheese BurgerCheese BurgerCheese BurgerCheese Burger",
      rate: "5.5",
      time: "12 min",
    ),
    Meal(
      name: "Fries",
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1672774750509-bc9ff226f3e8?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8RnJpZXN8ZW58MHx8MHx8fDA%3D",
      description: "FriesFriesFriesFriesFriesFriesFries",
      rate: "3.5",
      time: "40 min",
    ),
  ];

  void AddMeal(Meal meal) {
    try {
      meals.add(meal);
      loadmeals = meals;
      _saveMeals(meals);
      emit(MealAddSucssesstate());
    } catch (e) {
      emit(MealAddErrorstate());
      print(e);
    }
  }

  Future<void> loadMeals() async {
    emit(LoadingMeals());
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_prefsKey);

      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        meals = jsonList.map((json) => Meal.fromJson(json)).toList();
        emit(MealsLoaded());
      } else {
        emit(MealsError());
      }
    } catch (e) {
      print(e.toString());
      emit(MealsError());
    }
  }

  Future<void> addMeal(Meal newMeal) async {
    try {
      meals.add(newMeal);
      await _saveMeals(meals);
      emit(MealAddSucssesstate());
    } catch (e) {
      emit(MealAddErrorstate());
    } 
  }

  Future<void> removeMeal(String mealName) async {
    try {
      final newMeals = meals.where((meal) => meal.name != mealName).toList();
      await _saveMeals(newMeals);
      emit(RemoveMealSuccess());
    } catch (e) {
      emit(RemoveMealError());
    }
  }

  Future<void> clearMeals() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
      emit(ClearMealsSuccess());
    } catch (e) {
      emit(ClearMealsError());
    }
  }

  Future<void> _saveMeals(List<Meal> meals) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(
        meals.map((meal) => meal.toJson()).toList(),
      );
      await prefs.setString(_prefsKey, jsonString);
      emit(SaveMealsSuccess());
    } catch (e) {
      emit(SaveMealsError());
      rethrow;
    }
  }


  
}

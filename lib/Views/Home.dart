import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Core/Loading.dart';
import 'package:meal_app/Core/theme/theme.dart';

import 'package:meal_app/New/Apimodel.dart';
import 'package:meal_app/New/Cubit/RecipeCubit.dart';
import 'package:meal_app/New/Cubit/RecipeState.dart';

import 'package:meal_app/Views/ItemforGrid.dart';
import 'package:meal_app/Views/Cart/CartBadge.dart';
import 'package:meal_app/Views/Search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeCubit>().loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            isDark
                ? Colors.deepOrange.shade700
                : Colors.deepOrange.shade700.withOpacity(0.7),
        centerTitle: false,
        title: Text(
          'Our Recipes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          CartBadge(), // Add the CartBadge widget here
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: RecipeSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
            tooltip: isDark ? 'Light Mode' : 'Dark Mode',
          ),
        ],
      ),
      backgroundColor:
          isDark
              ? Colors.deepOrange.shade700
              : Colors.deepOrange.shade700.withOpacity(0.7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/p1.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 40,
                    width: 200,
                    height: 150,
                    child: Text(
                      "Welcome Add a New Recipe",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                //  height: 50,
                // color: Colors.red,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Recipe",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: BlocBuilder<RecipeCubit, RecipeState>(
                  builder: (context, state) {
                    if (state is RecipeLoading) {
                      return Center(child: LoadingLottie());
                    } else if (state is RecipeLoaded) {
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.55,
                        ),
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          // List<OrderModel> meals =
                          //     context.read<MealCubit>().meals;
                          Recipe recipe = state.recipes[index];

                          return ItemForGrid(recipe: recipe);
                        },
                      );
                    } else {
                      return Center(child: Text('No recipes found.'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

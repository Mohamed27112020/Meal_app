import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Core/Loading.dart';
import 'package:meal_app/New/Apimodel.dart' show Recipe;
import 'package:meal_app/New/Cubit/RecipeCubit.dart';
import 'package:meal_app/New/Cubit/RecipeState.dart';

class RecipeSearchDelegate extends SearchDelegate<Recipe?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    context.read<RecipeCubit>().searchRecipes(query);
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, state) {
        if (state is RecipeLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: state.recipes.length,
              itemBuilder: (context, index) {
                final recipe = state.recipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  subtitle: Text(recipe.cuisine),
                  leading: Image.network(recipe.image),
                  trailing: Text('Rating: ${recipe.rating}'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  style: ListTileStyle.list,
                  tileColor: isDark ? Colors.grey[800] : Colors.grey[200],
                  selectedTileColor:
                      isDark ? Colors.grey[700] : Colors.grey[300],
                  selected: false,
                  hoverColor: Colors.deepOrange[300],
                  onTap: () => close(context, recipe),
                );
              },
            ),
          );
        }
        return Center(child: LoadingLottie());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

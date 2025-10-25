import 'package:flutter/material.dart';
import 'package:meal_app/New/Apimodel.dart';
import 'package:meal_app/Views/mealdetails.dart';

class ItemForGrid extends StatelessWidget {
  ItemForGrid({super.key, required this.recipe});
  Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RecipeDetailsPage(recipe: recipe);
            },
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 5),
              Text(
                recipe.name.toString(),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.price_change_outlined, color: Colors.deepOrange),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      recipe.mealType.toString(),
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.production_quantity_limits_outlined,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      recipe.difficulty.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.rate_review_outlined, color: Colors.deepOrange),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      recipe.rating.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

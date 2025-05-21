import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Core/Snackbar.dart';
import 'package:meal_app/Cubit/MealCubit.dart';
import 'package:meal_app/Cubit/MealStates.dart';
import 'package:meal_app/Pages/AddMeal.dart';
import 'package:meal_app/Pages/mealdetails.dart';
import 'package:meal_app/model/Mealmodel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Addmeal();
              },
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<MealCubit, Mealstates>(
          listener: (context, state) {
            if (state is MealAddSucssesstate) {
              showSnackbar(context, "Meal Added", Colors.green);
            } else if (state is MealAddErrorstate) {
              showSnackbar(context, "Error", Colors.red);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  color: Colors.deepOrange,
                  width: double.infinity,
                  height: 200,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/p1.jpg",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
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
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  //  height: 50,
                  // color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Food",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: context.read<MealCubit>().meals.length,
                    itemBuilder: (context, index) {
                      List<Meal> meals = context.read<MealCubit>().meals;
                      return ItemForGrid(meal: meals[index]);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ItemForGrid extends StatelessWidget {
  ItemForGrid({super.key, required this.meal});
  Meal meal;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Mealdetails(meal: meal);
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
              Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              Text(
                meal.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.deepOrange),
                  Text(
                    meal.rate.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.timelapse_outlined, color: Colors.deepOrange),
                  Text(
                    meal.time,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

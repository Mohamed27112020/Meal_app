import 'package:flutter/material.dart';
import 'package:meal_app/model/Mealmodel.dart';

class Mealdetails extends StatelessWidget {
  Mealdetails({super.key, required this.meal});
  Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                    height: 350,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              meal.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Icon(Icons.star, size: 40, color: Colors.deepOrange),
                Text(
                  meal.rate.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.timelapse_outlined,
                  size: 40,
                  color: Colors.deepOrange,
                ),
                Text(
                  meal.time,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Divider(),
            Text(
              "Description",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              meal.description,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

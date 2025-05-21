import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Core/custom_text_field.dart';
import 'package:meal_app/Core/primay_button_widget.dart';
import 'package:meal_app/Cubit/MealCubit.dart';
import 'package:meal_app/model/Mealmodel.dart';

class Addmeal extends StatefulWidget {
  Addmeal({super.key});

  @override
  State<Addmeal> createState() => _AddmealState();
}

class _AddmealState extends State<Addmeal> {
  TextEditingController nameController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  TextEditingController rateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController decsController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    rateController.dispose();
    timeController.dispose();
    decsController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Meal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: nameController,
                  hintText: "Enter Meal Name",
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Enter Meal Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Image URL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: imageController,
                  hintText: "Enter Image URL",
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Enter Image URL";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Rate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: rateController,
                  hintText: "Enter Rate",
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Enter Rate";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: timeController,
                  hintText: "Enter Time",
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Enter Time";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: decsController,
                  hintText: "Enter Description",
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Enter Description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                PrimayButtonWidget(
                  buttonColor: Colors.deepOrange,
                  textColor: Colors.white,
                  width: double.infinity,
                  height: 56,
                  buttonText: "Add Meal",
                  onPress: () {
                    if (formkey.currentState!.validate()) {
                      context.read<MealCubit>().addMeal(
                        Meal(
                          name: nameController.text,
                          imageUrl: imageController.text,
                          rate: rateController.text ,
                          time: timeController.text,
                          description: decsController.text,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

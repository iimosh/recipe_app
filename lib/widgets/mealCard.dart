import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';

import '../models/food.dart';


class MealCard extends StatelessWidget {
  final Food food;

  const MealCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/meal_details", arguments: food);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromARGB(255, 136, 81, 101), width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(child: Image.network(food.img)),
              Divider(),
              Text(food.name, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

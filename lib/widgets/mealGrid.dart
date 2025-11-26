
import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/mealCard.dart';

import '../models/food.dart';

class MealGrid extends StatefulWidget{
  const MealGrid({super.key, required this.meals});

  final List<Food> meals;

  @override
  State<MealGrid> createState() {
    return _MealGridState();
  }

}

class _MealGridState extends State<MealGrid>{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 200/244
    ), itemCount: widget.meals.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index) {
          return MealCard(food: widget.meals[index]);

        });
  }

}
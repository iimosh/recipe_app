import 'package:flutter/material.dart';
import 'package:recipe_app/screens/meal.dart';
import 'package:recipe_app/screens/category_details.dart';
import 'package:recipe_app/screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
            255, 172, 198, 93)),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const HomePage(),
        "/details": (context) => const CategoryDetails(),
        "/meal_details": (context) => MealDetail(),
        },
    );
  }
}

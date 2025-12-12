import 'package:flutter/material.dart';
import 'package:recipe_app/screens/favorite_meals.dart';
import 'package:recipe_app/screens/meal.dart';
import 'package:recipe_app/screens/category_details.dart';
import 'package:recipe_app/screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        "/favorites": (context) => FavoriteMeals(),
        },
    );
  }
}

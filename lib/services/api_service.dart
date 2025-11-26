import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/food.dart';
import 'package:recipe_app/models/receipt.dart';

class ApiService {
  Future<List<Category>> loadCategoryList() async {
    List<Category> categoryList = [];

    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode == 200) {
      final detailResponse = json.decode(response.body);

      List categories = detailResponse['categories'];

      for (var category in categories) {
        Category cat = Category.fromJson(category);
        categoryList.add(cat);
      }
    }
    return categoryList;
  }
  Future<List<Food>> loadFoodList(String category) async {
    List<Food> foodList = [];

    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'),
    );

    if (response.statusCode == 200) {
      final detailResponse = json.decode(response.body);

      List meals = detailResponse['meals'];

      for (var meal in meals) {
        Food food = Food.fromJson(meal);
        foodList.add(food);
      }
    }
    return foodList;
  }

  Future<Receipt> loadReceipt(String id) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final detailResponse = json.decode(response.body);
      final meals = detailResponse['meals'];

      if (meals != null && meals.isNotEmpty) {
        return Receipt.fromJson(meals[0]);
      } else {
        throw Exception("No meal found for id $id");
      }
    } else {
      throw Exception("Failed to load receipt");
    }
  }

  Future<Food> loadRandomReceipt() async{
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
    );

    if (response.statusCode == 200) {
      final detailResponse = json.decode(response.body);
      final meals = detailResponse['meals'];

      return Food.fromJson(meals[0]);

    } else {
      throw Exception("Failed to load receipt");
    }
  }






}

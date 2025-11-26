import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/services/api_service.dart';
import 'package:recipe_app/widgets/mealGrid.dart';

import '../models/food.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailsState();
  }
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late Category category;
  bool _isLoading =true;
  bool _isLoaded = false;
  bool _isSearching = false;
  String _searchQuery = '';
  final ApiService _apiService =ApiService();
  late final List<Food> _foods;
  List<Food> _filteredFoods = [];
  final TextEditingController _searchController = TextEditingController();



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(!_isLoaded){
      category = ModalRoute
          .of(context)!
          .settings
          .arguments as Category;
      _loadFoodList();
      _isLoaded=true;
    }
  }

  Future<void> _loadFoodList() async {
    final list = await _apiService.loadFoodList(category.name);

    setState(() {
      _foods = list;
      _filteredFoods =list;
      _isLoading = false;
    });
  }

  void _filterMeals(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredFoods = _foods;
      } else {
        _filteredFoods = _foods
            .where(
              (cat) => cat.name.toLowerCase().contains(query.toLowerCase()),
        )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          category.name,
          style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search meals in ${category.name} by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                _filterMeals(value);
              },
            ),
          ),
          Expanded(
            child: _filteredFoods.isEmpty && _searchQuery.isNotEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 60,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No meals found.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
                : Center(child: MealGrid(meals: _filteredFoods),),
          ),
        ],
      ),
    );
  }


}
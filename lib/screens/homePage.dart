import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/widgets/categoryGrid.dart';

import '../models/food.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  late final List<Category> _categories;
  List<Category> _filteredCategories = [];
  late Food randomFood;

  bool _isLoading = true;
  bool _isSearching = false;
  String _searchQuery = '';

  Future<void> _loadCategoryList() async {
    final list = await _apiService.loadCategoryList();

    setState(() {
      _categories = list;
      _filteredCategories=list;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where(
              (cat) => cat.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  Future<void> _random() async {
    final res=await _apiService.loadRandomReceipt();
    Food meal= res;
    Navigator.pushNamed(context, "/meal_details", arguments: meal);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          "Food Categories",
          style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
        ),
        actions: [
          GestureDetector(
            onTap: _random,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green.shade900, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Random Meal",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 55, 80, 29),
                ),
              ),
            ),
          )

        ],
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
                      hintText: 'Search category by name...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      _filterCategories(value);
                    },
                  ),
                ),
                Expanded(
                  child: _filteredCategories.isEmpty && _searchQuery.isNotEmpty
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
                                'No categories found.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(child: CategoryGrid(categories: _filteredCategories)),
                ),
              ],
            ),
    );
  }
}

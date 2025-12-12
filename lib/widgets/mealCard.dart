import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/services/favorite_service.dart';

import '../models/food.dart';

class MealCard extends StatefulWidget {
  final Food food;

  const MealCard({super.key, required this.food});

  @override
  State<StatefulWidget> createState() {
    return _MealCardState();
  }
}

class _MealCardState extends State<MealCard> {
  final favoriteService = FavoriteService();

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = favoriteService.isFavorite(widget.food);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/meal_details", arguments: widget.food);
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
              Expanded(
                child: Stack(
                  children: [
                    Image.network(widget.food.img, fit: BoxFit.cover),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            favoriteService.toggle(widget.food);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Color.fromARGB(255, 197, 109, 139),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Text(widget.food.name, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

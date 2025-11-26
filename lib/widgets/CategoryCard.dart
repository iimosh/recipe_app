import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';


class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: category);
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
              Expanded(child: Image.network(category.img)),
              Divider(),
              Text(category.name, style: TextStyle(fontSize: 20)),
              Text(category.description, style: TextStyle(fontSize: 12, color: Colors.grey.shade600), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, ),
            ],
          ),
        ),
      ),
    );
  }
}

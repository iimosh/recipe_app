
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/widgets/CategoryCard.dart';

class CategoryGrid extends StatefulWidget{
  const CategoryGrid({super.key, required this.categories});

  final List<Category> categories;

  @override
  State<CategoryGrid> createState() {
    return _CategoryGridState();
  }

}

class _CategoryGridState extends State<CategoryGrid>{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 200/244
    ), itemCount: widget.categories.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index) {
      return CategoryCard(category: widget.categories[index]);

        });
  }

}
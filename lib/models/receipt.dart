import 'package:recipe_app/models/food.dart';

class Receipt extends Food{
  String instructions;
  List<String> ingredients;
  String youtube;

  Receipt({
    required super.id,
    required super.name,
    required super.img,
    required this.instructions,
    required this.ingredients,
    required this.youtube,
  });

  Receipt.fromJson(Map<String, dynamic> data)
      : instructions = data['strInstructions'] ?? '',
        youtube = data['strYoutube'] ?? '',
        ingredients = _extractIngredients(data),
        super.fromJson(data);

  static List<String> _extractIngredients(Map<String, dynamic> data) {
    List<String> list=[];

    for(int i=1; i<=20; i++){
      final ing= data['strIngredient$i'];
      if (ing != null && ing.toString().trim().isNotEmpty) {
        list.add(ing);
      } else{
        break;
      }
    }
    return list;
  }
}
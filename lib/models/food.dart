class Food{
  String id;
  String name;
  String img;

  Food({required this.id, required this.name, required this.img});

  Food.fromJson(Map<String, dynamic> data)
      : id = data['idMeal'],
        name = data['strMeal'],
        img = data['strMealThumb'];

  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': name,
    'strMealThumb': img,
  };
}
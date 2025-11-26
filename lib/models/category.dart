class Category {
  String id;
  String name;
  String description;
  String img;

  Category({required this.id, required this.name, required this.description, required this.img});

  Category.fromJson(Map<String, dynamic> data)
    : id = data['idCategory'],
      name = data['strCategory'],
      img = data['strCategoryThumb'],
      description = data['strCategoryDescription'];

  Map<String, dynamic> toJson() => {
    'idCategory': id,
    'strCategory': name,
    'strCategoryThumb': img,
    'strCategoryDescription': description,
  };
}

class CategoryModel {
  int? id;
  String? name;
  String? image;

//create constructor
  CategoryModel(this.id, this.name, this.image);

//Refactoring
  CategoryModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
  }

//create map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }
}

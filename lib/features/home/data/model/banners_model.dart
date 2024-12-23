class BannersModel {
  int? id;
  String? image;

//create constructor
  BannersModel(this.id, this.image);

//Refactoring
  BannersModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    image = data['image'];
  }

//create map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "image": image,
    };
  }
}

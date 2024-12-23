class ProductsModel {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

//create constructor
  ProductsModel(this.id, this.price, this.oldPrice, this.discount, this.image,
      this.name, this.description);

//Refactoring
  ProductsModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'].toInt();
    price = data['price'].toInt();
    oldPrice = data['old_price'].toInt();
    discount = data['discount'].toInt();
    image = data['image'].toString();
    name = data['name'].toString();
    description = data['description'].toString();
  }

//create map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "price": price,
      "oldPrice": oldPrice,
      "discount": discount,
      "image": image,
      "name": name,
      "description": description,
    };
  }
}

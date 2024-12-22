class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

//create constructor
  UserModel(
      {required this.id,
      required this.token,
      required this.email,
      required this.phone,
      required this.name,
      required this.image});

//Refactoring
  UserModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'].toInt();
    name = data['name'].toString();
    email = data['email'].toString();
    phone = data['phone'].toString();
    image = data['image'].toString();
    token = data['token'].toString();
  }

//create map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "image": image,
      "token": token,
    };
  }
}

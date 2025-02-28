class ProductCartModel {
  String? id;
  String? title;
  num? price;
  String? description;
  String? image;
  int? quantity;

  ProductCartModel({this.id, this.title, this.price, this.description, this.image, this.quantity});

  ProductCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'quantity': quantity,
      'image': image,
    };
  }
}

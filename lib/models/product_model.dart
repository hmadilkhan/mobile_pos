class ProductModel {
  int? id;
  String? name;
  String? description;
  String? unit;
  String? price;
  String? department;
  String? image;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.unit,
      this.price,
      this.department,
      this.image});

  ProductModel.dbFromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    unit = json["unit"];
    price = json["price"];
    department = json["department"];
    image = json['image'];
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['product_name'];
    description = json['product_description'];
    unit = json["uom"]['name'];
    price = json["apiprice"]?['retail_price'];
    image = json['image'];
    department = json['department']['department_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['unit'] = unit;
    data['price'] = price;
    data['image'] = image;
    data['department'] = department;
    return data;
  }
}

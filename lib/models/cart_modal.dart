import 'dart:ffi';

class Cart {
  int? id;
  String? name;
  String? description;
  String? unit;
  String? price;
  String? department;
  String? image;
  String? qty;
  String? amount;
  String? totalamount;

  Cart(
      {this.id,
      this.name,
      this.description,
      this.unit,
      this.price,
      this.department,
      this.image,
      this.qty,
      this.amount,
      this.totalamount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['unit'] = unit;
    data['price'] = price;
    data['image'] = image;
    data['department'] = department;
    data['qty'] = qty;
    data['amount'] = amount;
    data['totalamount'] = totalamount;
    return data;
  }

  Cart.dbFromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    description = json['description'];
    unit = json['unit'];
    price = json['price'];
    image = json['image'];
    department = json['department'];
    qty = json['qty'];
    amount = json['amount'];
    totalamount = json['totalamount'];
  }
}

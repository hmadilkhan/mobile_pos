class UserModel {
  int? id;
  String? token;
  String? name;
  String? company;
  String? branch;

  UserModel({this.id, this.token, this.name, this.company, this.branch});

  UserModel.dbFromJson(Map<String, dynamic> json) {
    id = json["id"];
    token = json['token'];
    name = json['name'];
    company = json['company'];
    branch = json['branch'];
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['data']['token'];
    name = json['data']['name'];
    company = json['data']['company'];
    branch = json['data']['branch'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['token'] = token;
  //   data['name'] = name;
  //   return data;
  // }

  Map<String, dynamic> toJson() => {
        // final Map<String, dynamic> data = <String, dynamic>{};
        'id': id,
        'token': token,
        'name': name,
        'company': company,
        'branch': branch,
      };
}

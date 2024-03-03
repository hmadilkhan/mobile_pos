class DepartmentModel {
  int? id;
  int? departmentId;
  int? companyId;
  String? code;
  String? departmentName;
  String? slug;
  String? image;
  String? date;
  String? time;

  DepartmentModel(
      {this.id,
      this.departmentId,
      this.companyId,
      this.code,
      this.departmentName,
      this.slug,
      this.image,
      this.date,
      this.time});

  DepartmentModel.DBFromJson(Map<String,dynamic> json){
    id = json["id"];
    departmentName = json["name"];
    code = json["code"];
    image = json["image"];
  }
  DepartmentModel.fromJson(Map<String, dynamic> json) {
    // print("From Json" + json['department_name']);
    // id = json['id'];
    departmentId = json['department_id'];
    // companyId = json['company_id'];
    code = json['code'];
    departmentName = json['department_name'];
    // slug = json['slug'];
    image = json['image'];
    // date = json['date'];
    // time = json['time'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   // data['department_id'] = departmentId;
  //   // data['company_id'] = companyId;
  //   data['code'] = code;
  //   data['department_name'] = departmentName;
  //   data['slug'] = slug;
  //   data['image'] = image;
  //   // data['date'] = date;
  //   // data['time'] = time;
  //   return data;
  // }

  Map<String, dynamic> toJson() => {
        // final Map<String, dynamic> data = <String, dynamic>{};
        'id': id,
        // 'departmentId': departmentId,
        'code': code,
        'name': departmentName,
        // 'slug': slug,
        'image': image,
      };
}

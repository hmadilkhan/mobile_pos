import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_pos/models/department_model.dart';
import 'package:mobile_pos/services/database_helper.dart';
import 'package:mobile_pos/utils/api-list.dart';
import 'package:mobile_pos/utils/server.dart';
import 'package:mobile_pos/widgets/pos_screen/products.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class PosService {
  Server server = Server();
  List<DepartmentModel> departments = [];
  List<ProductModel> products = [];
  Future<List<DepartmentModel>?> getDepartments() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      final uri = Uri.parse(APIList.department);
      final response = await http.post(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token.toString(),
      });
      if (response.statusCode == 200) {
        // deleteAllDepartment();
        departments = parseDepartments(response.body);
        for (var depart in departments) {
          // print("Service : ${depart.departmentName}");
          final department = DepartmentModel(
            code: depart.code,
            departmentName: depart.departmentName,
            image: depart.image,
          );
          // print("Service : ${department.departmentName}");
          addDepartment(department);
        }

        return departments;
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      return null;
    }
  }

  List<DepartmentModel> parseDepartments(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed
        .map<DepartmentModel>((json) => DepartmentModel.fromJson(json))
        .toList();
  }

  List<ProductModel> parseProducts(String responseBody) {
    final parsed =
    (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
  }

  Future<List<ProductModel>> getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final uri = Uri.parse(APIList.products);
    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token.toString(),
    });
    if (response.statusCode == 200) {
      products = parseProducts(response.body);
      for (var product in products) {
        final prod = ProductModel(
          name: product.name,
          description: product.description,
          image: product.image,
          unit: product.unit,
          price: product.price,
        );
        addProduct(product);
      }
      return products;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<int> addDepartment(DepartmentModel department) async {
    return await DatabaseHelper.addDeparment(department);
  }

  Future<int> deleteAllDepartment() async {
    return await DatabaseHelper.deleteAllDepartment();
  }

  Future<int> addProduct(ProductModel product) async {
    return await DatabaseHelper.addProduct(product);
  }

  Future<int> deleteAllProduct() async {
    return await DatabaseHelper.deleteAllProduct();
  }
}

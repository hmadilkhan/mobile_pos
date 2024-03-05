import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile_pos/models/department_model.dart';
import 'package:mobile_pos/models/product_model.dart';
import 'package:mobile_pos/models/user_model.dart';
import 'package:mobile_pos/screens/pos_screen.dart';
import 'package:mobile_pos/services/database_helper.dart';
import 'package:mobile_pos/services/pos_service.dart';
import 'package:mobile_pos/utils/api-list.dart';
import 'package:mobile_pos/utils/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends GetxController {
  Server server = Server();
  PosService service = PosService();

  Future<UserModel?> login(email, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map body = {'username': email, 'password': password};
    String jsonBody = json.encode(body);
    try {
      server
          .postRequest(endPoint: APIList.login, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          var userModel = UserModel.fromJson(jsonResponse);
          prefs.setBool("isLogedIn", true);
          var bearerToken = 'Bearer ${userModel.token}';
          prefs.setString("justToken", userModel.token.toString());
          prefs.setString("company", userModel.company.toString());
          prefs.setString("branch", userModel.branch.toString());
          prefs.setString("token", bearerToken);
          addUser(userModel)
              .then((value) => getDepartments())
              .then((value) => getProducts())
              .then((value) => Get.offAll(() => const PosScreen()));
          return userModel;
        } else {
          // final jsonResponse = json.decode(response.body);
          prefs.setBool("isLogedIn", false);
          return null;
        }
      });
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<int> addUser(UserModel userModel) async {
    return await DatabaseHelper.addUser(userModel);
  }

  Future<List<DepartmentModel>?> getDepartments() async {
    return await service
        .deleteAllDepartment()
        .then((value) => service.getDepartments());
    // return await service.getDepartments();
  }

  Future<List<ProductModel>?> getProducts() async {
    return await service
        .deleteAllProduct()
        .then((value) => service.getProducts());
    // return await service.getDepartments();
  }
}

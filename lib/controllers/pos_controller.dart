import 'package:get/get.dart';
import 'package:mobile_pos/models/product_model.dart';
import 'package:mobile_pos/services/database_helper.dart';

class PosController extends GetxController {
  RxString productSearchText = "".obs;
  RxInt selectedIndex = 0.obs;
  RxString departmentName = "All".obs;
  // final listProduct = Future.value(<ProductModel>[]).obs;
  final listProduct = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    allProducts();
  }

  void changeDepartment(department) {
    departmentName.value = department;
    allProducts();
    update();
  }

  void productSearch(text) {
    productSearchText.value = text;
    getProductsByName();
    update();
  }

  Future<List<ProductModel>?> getAllProducts() async {
    var result = await DatabaseHelper.getAllProducts(departmentName.value);
    update();
    return result;
  }

  Future<List<ProductModel>?> allProducts() async {
    listProduct.value = [];
    final List<Map<String, dynamic>> maps =
        await DatabaseHelper.getProductsByDepartment(departmentName.value);
    var results = List.generate(
        maps.length, (index) => ProductModel.dbFromJson(maps[index]));
    listProduct.value = results;
    return results;
  }

  Future<List<ProductModel>?> getProductsByName() async {
    listProduct.value = [];
    final List<Map<String, dynamic>> maps =
        await DatabaseHelper.getProductsByName(productSearchText.value);
    var results = List.generate(
        maps.length, (index) => ProductModel.dbFromJson(maps[index]));
    listProduct.value = results;
    return results;
  }
}

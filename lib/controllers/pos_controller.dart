import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_pos/models/product_model.dart';
import 'package:mobile_pos/services/database_helper.dart';

class PosController extends GetxController {
  String dummyText = "hello";
  RxInt selectedIndex = 0.obs;
  RxString departmentName = "All".obs;
  final listProduct = Future.value(<ProductModel>[]).obs;
  // final listProduct = <ProductModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    AllProducts();
  }

  void changeDepartment(department)
  {
    departmentName.value = department;
    print(department);
    this.AllProducts();
    update();
  }

  Future<List<ProductModel>?> getAllProducts() async {
    return await DatabaseHelper.getAllProducts(departmentName.value);
  }

  Future<List<ProductModel>?> AllProducts() async {
    // listProduct.assignAll([]);
    final List<Map<String, dynamic>> maps =  await DatabaseHelper.getProductsByDepartment(departmentName.value);
    var results = List.generate(
            maps.length, (index) =>
         ProductModel.dbFromJson(maps[index]));
    // listProduct.value = results;
    // for(var product in listProduct.value){
    //   print(product.department);
    // }
  }

}
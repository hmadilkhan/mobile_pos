import 'package:get/get.dart';
import 'package:mobile_pos/models/cart_modal.dart';
import 'package:mobile_pos/services/database_helper.dart';

class CartController extends GetxController {
  var listItems = <Cart>[].obs;

  @override
  void onInit() {
    super.onInit();
    allItems();
    DatabaseHelper.deleteAllItemsOfCart();
    listItems = <Cart>[].obs;
    update();
  }

  Future<List<Cart>?> allItems() async {
    listItems.value = [];
    final List<Map<String, dynamic>> maps =
        await DatabaseHelper.getAllItemOfCart();
    var results =
        List.generate(maps.length, (index) => Cart.dbFromJson(maps[index]));
    listItems.value = results;
    return results;
  }

  void addItem(quantity, product, mode) async {
    var qty = 1;
    var result = await DatabaseHelper.querySpecificData(product.id);
    if (!result.isEmpty) {
      qty = int.parse(result?[0]["qty"]);
      qty++;
    }
    if (mode == "cart") {
      print(quantity < qty);
      if (quantity < qty) {
        qty = quantity;
        qty--;
      }
    }
    var cart = Cart();
    cart.id = product.id;
    cart.name = product.name;
    cart.description = product.description;
    cart.unit = product.unit;
    cart.price = product.price;
    cart.image = product.image;
    cart.department = product.department;
    cart.qty = qty.toString();
    cart.amount = (qty * double.parse(product.price)).toString();
    cart.totalamount = (qty * double.parse(product.price)).toString();

    var count = await DatabaseHelper.checkItemInCart(cart);
    if (count == 0) {
      await DatabaseHelper.addItemToCart(cart);
    } else {
      await DatabaseHelper.updateItemToCart(cart);
    }

    if (qty == 0) {
      await DatabaseHelper.deleteItemToCart(cart);
    }
    // else {
    // if (count == 0) {
    //   await DatabaseHelper.addItemToCart(cart);
    // } else {
    //   await DatabaseHelper.updateItemToCart(cart);
    // }
    // }
    allItems();
    update();
  }
}

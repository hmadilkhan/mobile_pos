import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_pos/models/cart_modal.dart';
import 'package:mobile_pos/services/database_helper.dart';
import 'package:mobile_pos/utils/colors.dart';

class CartController extends GetxController {
  var listItems = <Cart>[].obs;
  RxDouble subtotal = 0.00.obs;
  RxDouble taxamount = 0.00.obs;
  RxDouble deliveryCharges = 100.00.obs;
  RxDouble total = 0.00.obs;

  @override
  void onInit() {
    super.onInit();
    allItems();
    emptyCart();
    print("Init calling");
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
      if (quantity < qty) {
        qty = quantity;
        // qty--;
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

    calculateSubTotal();
    allItems();
    update();
  }

  void calculateSubTotal() async {
    var subtotalAmount = await DatabaseHelper.sumAmountOfCart();
    if (subtotalAmount[0]["Total"] != null) {
      subtotal.value = subtotalAmount[0]["Total"];
    }
    total.value = subtotal.value + taxamount.value + deliveryCharges.value;
  }

  void emptyCart() {
    DatabaseHelper.deleteAllItemsOfCart();
    listItems = <Cart>[].obs;
    taxamount = 0.00.obs;
    subtotal.value = 0.00;
    total = 0.00.obs;
    update();
  }

  void showDicountDialog() {
    Get.dialog(
      Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 600, vertical: 200),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: AppColors.charcoal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppBar(
                centerTitle: true,
                title: const Text("Add Discount"),
                leading: const Icon(Icons.arrow_back),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
                backgroundColor: Colors.transparent,
              ),
            ),
            Divider(
              color: AppColors.primary,
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: AppColors.white,
                            icon: Icon(
                              Icons.percent,
                              color: AppColors.primary,
                              size: 30,
                            ),
                            tooltip: 'By Percentage %',
                            onPressed: () {},
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white),
                          ),
                          const Text('By Percentage',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Poppins",
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: AppColors.white,
                            icon: Icon(
                              Icons.percent,
                              color: AppColors.primary,
                              size: 30,
                            ),
                            tooltip: 'By Amount',
                            onPressed: () {},
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white),
                          ),
                          const Text('By Amount',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Poppins",
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // Get.defaultDialog(

    // title: "Add Discount",
    // content: Column(
    //   children: [
    //     AppBar(
    //       title: Text("Add Discount"),
    //       leading: Icon(Icons.back_hand),
    //       actions: [Icon(Icons.close)],
    //     )
    //   ],
    // ),
    // actions: [
    //   TextButton(
    //     child: const Text("Ok"),
    //     onPressed: () => Get.back(),
    //   ),
    //   TextButton(
    //     child: const Text("Close"),
    //     onPressed: () => Get.back(),
    //   ),
    // ],
    // );
  }
}

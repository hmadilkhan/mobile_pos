import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  RxBool percentMode = false.obs;
  RxBool amountMode = false.obs;
  RxDouble discountTextValue = 0.00.obs;
  RxDouble discountAmount = 0.00.obs;

  @override
  void onInit() {
    super.onInit();
    allItems();
  }

  Future<List<Cart>?> allItems() async {
    listItems.value = [];
    final List<Map<String, dynamic>> maps =
        await DatabaseHelper.getAllItemOfCart();
    var results =
        List.generate(maps.length, (index) => Cart.dbFromJson(maps[index]));
    listItems.value = results;
    calculateSubTotal();
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
      calculateSubTotal();
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
    applyDiscount();
    total.value = subtotal.value +
        taxamount.value +
        deliveryCharges.value -
        discountAmount.value;
    update();
  }

  void emptyCart() {
    DatabaseHelper.deleteAllItemsOfCart();
    listItems = <Cart>[].obs;
    taxamount = 0.00.obs;
    subtotal.value = 0.00;
    total = 0.00.obs;
    discountAmount.value = 0.00;
    percentMode.value = false;
    amountMode.value = false;
    update();
  }

  void showDicountDialog() {
    Get.dialog(
      Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 400, vertical: 200),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: AppColors.charcoal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppBar(
                centerTitle: true,
                title: Text(
                  "Apply Discount",
                  style: TextStyle(color: AppColors.white),
                ),
                leading: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AppColors.white,
                    ),
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
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          amountMode.value = false;
                          percentMode.value = true;
                        },
                        child: Container(
                          width: 120,
                          height: 100,
                          decoration: BoxDecoration(
                              color: (percentMode.value == true
                                  ? AppColors.primary
                                  : Colors.black26),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          amountMode.value = true;
                          percentMode.value = false;
                        },
                        child: Container(
                          width: 120,
                          height: 100,
                          decoration: BoxDecoration(
                            color: (amountMode.value == true
                                ? AppColors.primary
                                : Colors.black26),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                color: AppColors.white,
                                icon: Icon(
                                  Icons.currency_lira_outlined,
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
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: AppColors.white,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
                ],
                onChanged: (value) {
                  if (value != "") {
                    discountTextValue.value = double.parse(value);
                  }
                },
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.white, width: 0.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  fillColor: AppColors.white,
                  focusColor: AppColors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.white, width: 0.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Container(
              width: Get.width * 0.34,
              padding: const EdgeInsets.all(18.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: AppColors.primary,
                  width: 3.0,
                  style: BorderStyle.solid,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  applyDiscount();
                  Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
                },
                child: Text(
                  'APPLY DISCOUNT %',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void applyDiscount() {
    if (percentMode.value == true) {
      discountAmount.value = (discountTextValue.value / 100) * subtotal.value;
    } else if (amountMode.value == true) {
      discountAmount.value = discountTextValue.value;
    }
    var discounttotal = subtotal.value +
        taxamount.value +
        deliveryCharges.value -
        discountAmount.value;
    total.value = double.parse(discounttotal.toStringAsFixed(2));
    update();
    // calculateSubTotal();
  }
}

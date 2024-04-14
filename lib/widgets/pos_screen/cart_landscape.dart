import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/cart_controller.dart';
import 'package:mobile_pos/utils/colors.dart';
import 'package:mobile_pos/widgets/pos_screen/cart_item.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) {
    // print(Get.width);
    // print(Get.height);
    return GetBuilder<CartController>(builder: (controller) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.3,
        margin: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.29,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: AppColors.charcoal,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: AppColors.primary,
                  width: 3.0,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "ORDER CART",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Transform.scale(
                          scale: 1.3,
                          child: IconButton(
                            icon: Icon(
                              Icons.discount_outlined,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              controller.showDicountDialog();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Transform.scale(
                          scale: 1.3,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              // do something
                              controller.emptyCart();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              // flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.29,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.charcoal,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Obx(
                  () => (controller.listItems.isEmpty
                      ? const Center(
                          child: Text(
                            "No Items in the cart.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Poppins",
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: controller.listItems.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                height: 1,
                                color: AppColors.primary,
                              ),
                          itemBuilder: (context, index) {
                            final product = controller.listItems[index];
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.red.shade400,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    onPressed: (context) => _onDismissed(),
                                  ),
                                ],
                              ),
                              child: CartItem(product),
                            );
                          })),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.29,
              height: MediaQuery.of(context).size.height * 0.20,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: AppColors.charcoal,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: AppColors.primary,
                  width: 3.0,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sub Total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. ${controller.subtotal.value}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tax",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. ${controller.taxamount.value}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Delivery Charges",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. ${controller.deliveryCharges.value}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, left: 5.0, bottom: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Discount ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. ${controller.discountAmount.value}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: double.minPositive,
                    color: AppColors.primary,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. ${controller.total.value}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.29,
              height: MediaQuery.of(context).size.height * 0.07,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: AppColors.primary,
                  width: 3.0,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'PLACE ORDER',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _onDismissed() {}
}

import 'package:flutter/material.dart';
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
              child: const Center(
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
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.29,
                height: MediaQuery.of(context).size.height * 0.6,
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
                            // final product = snapshot.data?[index];
                            final product = controller.listItems[index];
                            return CartItem(product);
                          })),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.29,
              height: MediaQuery.of(context).size.height * 0.17,
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
                  const Padding(
                    padding: EdgeInsets.only(
                        right: 5.0, left: 5.0, bottom: 3.0, top: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. 1599",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(right: 5.0, left: 5.0, bottom: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. 500",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(right: 5.0, left: 5.0, bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Charges",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. 100",
                          style: TextStyle(
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
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0, left: 5.0, top: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "Rs. 1599",
                          style: TextStyle(
                            fontSize: 24,
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
            )
          ],
        ),
      );
    });
  }
}

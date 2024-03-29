import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/utils/colors.dart';
import 'package:path/path.dart';

class ProductItemsLandscape extends StatefulWidget {
  const ProductItemsLandscape({super.key});

  @override
  State<ProductItemsLandscape> createState() => _ProductItemsLandscapeState();
}

class _ProductItemsLandscapeState extends State<ProductItemsLandscape> {
  int _counterInit = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosController>(builder: (controller) {
      return Expanded(
        child: Obx(
          () => (controller.listProduct.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: controller.listProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemBuilder: (BuildContext context, int index) {
                        final product = controller.listProduct[index];
                        return Card(
                          elevation: 5.0,
                          color: Colors.black,
                          child: GridTile(
                            footer: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      fadeInCurve: Curves.bounceIn,
                                      placeholder:
                                          "assets/images/placeholder.png",
                                      image:
                                          "https://retail.sabsoft.com.pk/assets/images/products/${product.image}",
                                      fit: BoxFit.cover,
                                      height: 90.0,
                                      width: 90.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6.0),
                                  margin: const EdgeInsets.only(top: 1.0),
                                  child: Text(
                                    product.name.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Price",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.charcoal,
                                                fontFamily: "Poppins",
                                              )),
                                          Text(
                                            "PKR. ${product.price}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.primary,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                        ],
                                      ),
                                      CartStepperInt(
                                        size: 24,
                                        style: CartStepperStyle(
                                          radius: const Radius.circular(5),
                                          foregroundColor: AppColors.primary,
                                          activeForegroundColor: Colors.white,
                                          activeBackgroundColor:
                                              AppColors.primary,
                                          buttonAspectRatio: 0.8,
                                        ),
                                        elevation: 5,
                                        value: _counterInit,
                                        didChangeCount: (count) {
                                          setState(() {
                                            _counterInit = count;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            child: const Center(),
                          ),
                        );
                      }),
                )),
        ),
      );
    });
  }
}

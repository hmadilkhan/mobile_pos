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
                        return Container(
                          color: Colors.black26,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                    "https://retail.sabsoft.com.pk/assets/images/products/${product.image}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  product.name.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                            fontFamily: "Poppins",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                        // return Card(
                        //   color: Colors.black,
                        //   child: GridTile(
                        //     footer: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.all(4.0),
                        //           child: Text(
                        //             product.name.toString(),
                        //             style: const TextStyle(
                        //               fontSize: 13,
                        //               fontWeight: FontWeight.w600,
                        //               color: Colors.white,
                        //               fontFamily: "Poppins",
                        //             ),
                        //           ),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.all(5.0),
                        //           child: Row(
                        //             children: [
                        //               Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text("Price",
                        //                       style: TextStyle(
                        //                         fontSize: 12,
                        //                         fontWeight: FontWeight.w600,
                        //                         color: AppColors.charcoal,
                        //                         fontFamily: "Poppins",
                        //                       )),
                        //                   Text(
                        //                     "PKR. ${product.price}",
                        //                     style: TextStyle(
                        //                       fontSize: 12,
                        //                       fontWeight: FontWeight.w600,
                        //                       color: AppColors.primary,
                        //                       fontFamily: "Poppins",
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Row(
                        //                 children: [],
                        //               )
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     child: SizedBox(
                        //       width: 100,
                        //       height: 100,
                        //       child:
                        //           Image.asset("assets/images/placeholder.png"),
                        //     ),
                        //   ),
                        // );
                      }),
                )),
        ),
      );
    });
  }
}

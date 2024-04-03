import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/utils/colors.dart';
import 'package:mobile_pos/widgets/pos_screen/item_card.dart';

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
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
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
                        return ItemCard(product);
                      }),
                )),
        ),
      );
    });
  }
}
